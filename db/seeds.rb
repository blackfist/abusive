User.create!({email:ENV['DEFAULT_ADMIN_EMAIL_ADDRESS'],
  password: ENV['DEFAULT_ADMIN_PASSWORD'],
  password_confirmation: ENV['DEFAULT_ADMIN_PASSWORD']})
