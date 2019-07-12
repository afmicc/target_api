module Helpers
  def json_value(data, *properties)
    value = data
    properties.each { |property| value = value[property] }
    value
  end

  def auth_user_header(headers)
    {
      'access-token': json_value(headers, 'access-token'),
      'client': json_value(headers, 'client'),
      'uid': json_value(headers, 'uid'),
      'expiry': json_value(headers, 'expiry'),
      'token_type': json_value(headers, 'token-type')
    }
  end
end
