require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :request do
  let!(:items_list) { create_list :item, 10 }
  let(:item_id) { items_list.first.id }

  describe "GET '/items'" do
    before { get "/items" }

    it { expect(json.count).to eq items_list.count }
    it { expect(json).not_to be_empty }
    it { expect(response).to have_http_status 200 }
  end

  describe "GET '/items/:id'" do
    before { get "/items/#{item_id}" }

    context "When the record exists" do
      it { expect(json["id"]).to eq items_list.first.id }
      it { expect(response).to have_http_status 200 }
    end

    context "When the record doesn't exists" do
      let(:item_id) { 100 }

      it { expect(json["message"]).to match /Couldn't find Item/ }
      it { expect(response).to have_http_status 404 }
    end
  end

  describe "POST '/items'" do
    let(:valid_params) {{ name: "Item name", price: "100" }}
    let(:invalid_params) {{ name: nil, price: "100" }}

    context "When send valid params" do
      before { post "/items", params: valid_params }

      it { expect(json["name"]).to eq valid_params[:name] }
      it { expect(response).to have_http_status 201 }
    end

    context "When send invalid params" do
      before { post "/items", params: invalid_params }

      it { expect(response).to have_http_status 422 }
      it { expect(json["message"]).to match /Validation failed/ }
    end
  end

  describe "PATCH '/items/:id'" do
    let(:valid_params) {{ name: "Item updated name" }}
    let(:invalid_params) {{ name: nil }}

    context "When send valid params" do
      before { put "/items/#{item_id}", params: valid_params }

      it { expect(response).to have_http_status 204 }
    end

    context "When send invalid params" do
      before { put "/items/#{item_id}", params: invalid_params }

      it { expect(response).to have_http_status 422 }
      it { expect(json["message"]).to match /Validation failed/ }
    end
  end

  describe "DELETE '/items/:id'" do
    before { delete "/items/#{item_id}" }

    context "When the record exists" do
      it { expect(response).to have_http_status 204 }
    end

    context "When the record doesn't exists" do
      let(:item_id) { 100 }

      it { expect(json["message"]).to match /Couldn't find Item/ }
      it { expect(response).to have_http_status 404 }
    end
  end
end
