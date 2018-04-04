Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, path: "/" do
    scope module: :v1 do
      resources :items
    end
  end

  root "api/v1/items#index"
end
