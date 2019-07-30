Rails.application.routes.draw do
  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              controllers: { registrations: 'api/v1/registrations' }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do

        resources :users, only: :update
        resources :targets, only: %i[index create destroy] do
          get 'compatible', on: :collection
        end
        resources :contact_admin, only: %i[create]
        resources :general_informations, only: :show, param: :key

        resources :chat_rooms, only: %i[create show index]

        mount ActionCable.server => '/cable'
      end
    end
  end
end
