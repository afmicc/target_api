module Helpers
  def json_value(data, *properties)
    value = data
    properties.each { |property| value = value[property] }
    value
  end
end
