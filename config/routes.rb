Rails.application.routes.draw do
  namespace :api, path: "/" do
    scope module: :v1 do
      resources :items
    end
  end
end
