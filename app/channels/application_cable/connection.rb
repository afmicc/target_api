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

      return reject_unauthorized_connection if
        !user || !user.valid_token?(params[:access_token], params[:client])

      user
    end

    private

    def header_params
      params = request.params
      {
        access_token: params['access-token'],
        client: params['client'],
        token_type: params['token-type'],
        uid: params['uid']
      }
    end
  end
end
