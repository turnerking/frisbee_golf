# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_frisbee_golf_session',
  :secret      => 'b7cc4c97be7c62bafd400f81b8b295b0ae9cdb8f5b6e4663978ede1c8e78acd7d6ed403021a423dd8a1dc589344b25ab49f698ce33d0e8435ecf7615a42db261'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
