class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    json_response Item.all
  end

  def show
    json_response @item
  end

  def create
    @item = Item.create! item_params
    json_response @item, :created
  end

  def update
    @item.update! item_params
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :price)
  end

  def set_item
    @item = Item.find params[:id]
  end
end
