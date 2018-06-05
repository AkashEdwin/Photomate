OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '951418980084-h4482ffrg0b6n860cikh04ssunutr44n.apps.googleusercontent.com', '951418980084-h4482ffrg0b6n860cikh04ssunutr44n.apps.googleusercontent.com', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end