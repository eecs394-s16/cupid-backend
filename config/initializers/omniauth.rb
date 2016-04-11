OmniAuth.config.logger = Rails.logger



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226725207682997', 'f457e3ba5c343fb63cf28453b0d29351', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
