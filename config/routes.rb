Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User',
                                  at: 'auth',
                                  controllers: { registrations: 'api/v1/registrations' }
      resources :users, defaults: { format: :json }, only: %i[update]
      resources :targets, defaults: { format: :json }, only: %i[index create]
    end
  end
end
