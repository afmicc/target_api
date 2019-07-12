Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User',
                                  at: 'auth',
                                  controllers: { registrations: 'api/v1/registrations' }

      # devise_for :users, controllers: {
      #   registrations: 'api/v1/registrations',
      #   sessions: 'api/v1/sessions',
      #   omniauth_callbacks: 'api/v1/omniauth_callbacks'
      # }
    end
  end
end
