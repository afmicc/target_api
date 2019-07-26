class NotificationService
  def send_compatible_target(users, target)
    params = {
      data: { 'target_id': target.id },
      filters: users_filter(users),
      contents: { 'en': I18n.t('api.notification.target.new', title: target.title) }
    }

    delay.send_notification(params)
  end

  def send_test(email)
    params = {
      filters: [{ 'field': 'tag', 'key': 'email', 'relation': '=', 'value': email }],
      contents: { 'en': 'This is a test' }
    }

    delay.send_notification(params)
  end

  private

  def send_notification(params)
    params[:app_id] = ENV['one_signal_app_id']
    OneSignal::OneSignal.api_key = ENV['one_signal_app_key']
    OneSignal::Notification.create(params: params)
  end

  def users_filter(users)
    filters = users.map { |user| { field: 'tag', key: 'email', relation: '=', value: user.email } }

    return filters unless filters.length > 1

    filters.flat_map { |filter| [filter, { 'operator': 'OR' }] }.tap(&:pop)
  end
end
