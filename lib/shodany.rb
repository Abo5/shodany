# lib/shodany.rb
# Main file for the Shodany library, requires necessary components.
require_relative 'shodany/version'
require_relative 'shodany/api'
require_relative 'shodany/client'

# Defines the Shodany module to provide a simple interface for users.

module Shodany
  def self.new(api_key)
    ShodanyClient.new(api_key) # Method to create a new instance of ShodanyClient with the provided API key.
  end
end