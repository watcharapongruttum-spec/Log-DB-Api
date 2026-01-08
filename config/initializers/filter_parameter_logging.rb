Rails.application.config.filter_parameters += [
  :passw,               
  :password_digest,
  :secret,
  :jwt,
  :authorization,
  :access_token,
  :refresh_token,
  :api_key,
  :_key,
  :crypt,
  :salt,
  :certificate,
  :otp,
  :ssn,
  :cvv,
  :cvc
]
