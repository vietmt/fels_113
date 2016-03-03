Warden::Manager.after_authentication do |record, warden, options|
  clean_up_for_winning_strategy = !warden.winning_strategy.respond_to?(:clean_up_csrf?) ||
    warden.winning_strategy.clean_up_csrf?
  if Devise.clean_up_csrf_token_on_authentication && clean_up_for_winning_strategy
    warden.request.session.try :delete, :_csrf_token
  end
  CUSTOM_LOGGER.info "%s::Sign In::%s::%s" %[record.email, DateTime.now.to_s,
    record.current_sign_in_ip] if record.admin?
end

Warden::Manager.before_logout do |record, warden, options|
  if record.respond_to? :forget_me!
    Devise::Hooks::Proxy.new(warden).forget_me record
  end
  CUSTOM_LOGGER.info "%s::Sign Out::%s::%s" %[record.email, DateTime.now.to_s,
    record.current_sign_in_ip] if record.admin?
end
