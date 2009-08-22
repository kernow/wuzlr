# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wuzler_session',
  :secret      => '0f5be3f0fd3d1adabc511f6dd5b1d04c684faa992c1cc75e4d624bb98bbb72f2eb51f97e58c9a6d8ef0ee1708e4491858b5e837c75e2f72ef50b3917be578543'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
