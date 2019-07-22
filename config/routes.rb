Rails.application.routes.draw do
  mount_devise_token_auth_for 'User',
                              at: 'api/v1/auth',
                              controllers: { registrations: 'api/v1/registrations' }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        resources :users, only: %i[update]
        resources :targets, only: %i[index create destroy]
      end
    end
  end
end
