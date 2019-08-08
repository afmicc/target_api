Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              controllers: { registrations: 'api/v1/registrations' }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        resources :users, only: %i[show update]
        resources :targets, only: %i[index create destroy] do
          get 'compatible', on: :collection
        end
        resources :contact_admin, only: %i[create]
        resources :general_informations, only: :show, param: :key
        resources :topics, only: :index
      end
    end
  end
end
