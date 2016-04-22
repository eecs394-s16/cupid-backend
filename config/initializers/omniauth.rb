require 'omniauth-facebook'


OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226749644347220', '8b2fc0e27233917470255ac373bd4b3c',
           :scope => 'email, user_friends', :display => 'popup',
  info_fields: 'email, first_name, last_name, gender, picture',
  :image_size => {width: '200'}
end
