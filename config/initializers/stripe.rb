case Rails.env
when "development"
  publishable_key = Rails.application.credentials[Rails.env.to_sym][:stripe][:publishable_key]
  secret_key = Rails.application.credentials[Rails.env.to_sym][:stripe][:secret_key]
when "production"
  publishable_key = ENV['publishable_key']
  secret_key = ENV['secret_key']
end

Rails.configuration.stripe = {
  publishable_key: publishable_key,
  secret_key: secret_key
}
Stripe.api_key = secret_key
