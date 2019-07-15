Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User',
                                  at: 'auth',
                                  controllers: { registrations: 'api/v1/registrations' }
      resources :targets, only: %i[index create]
      resources :users, only: %i[update]
    end
  end
end
