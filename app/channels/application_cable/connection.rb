module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user
      params = header_params
      user = User.find_by_uid(params[:uid])
      if user&.valid_token?(params[:access_token], params[:client])
        user
      else
        reject_unauthorized_connection
      end
    end

    private

    def header_params
      {
        access_token: request.params['access-token'],
        client: request.params['client'],
        token_type: request.params['token-type'],
        uid: request.params['uid'],
      }
    end
  end
end
