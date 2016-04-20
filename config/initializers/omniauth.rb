require 'omniauth-facebook'


OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226749644347220', '8b2fc0e27233917470255ac373bd4b3c',
           :scope => 'email', 'user_friends'
end
