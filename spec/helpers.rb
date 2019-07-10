module Helpers
  def json_value(data, *properties)
    value = data
    properties.each { |property| value = value[property] }
    value
  end

  def auth_user_header(headers)
    client = json_value(headers, 'client')
    access_token = json_value(headers, 'access-token')
    expiry = json_value(headers, 'expiry')
    token_type = json_value(headers, 'token-type')
    uid = json_value(headers, 'uid')

    {
      'access-token': access_token,
      'client': client,
      'uid': uid,
      'expiry': expiry,
      'token_type': token_type
    }
  end
end
