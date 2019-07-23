module Helpers
  def json_value(data, *properties)
    value = data
    properties.each { |property| value = value[property] }
    value
  end

  def auth_header
    user.create_new_auth_token
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

  def url_query_parameters(url)
    Rack::Utils.parse_query(URI.parse(url).query)
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end

  def email_link_url(email)
    email.body.match(/href="(?<url>.+?)">/)[:url]
  end

  def replace_param_token(url, param)
    url.gsub!(/#{param}\=([^\&]+)/) do |match|
      match.gsub!(Regexp.last_match(1), Faker::Alphanumeric.alphanumeric(20))
    end
  end
end
