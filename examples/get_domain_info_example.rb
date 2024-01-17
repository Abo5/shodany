# get_domain_info_example.rb
# Include the Shodany library
require 'shodany'

# Initialize a new Shodany client with your API key
client = Shodany.new("YOUR_API_KEY")
# Specify the domain for which you want information
domain = "example.com"

# Begin exception handling
begin
  # Get domain information from Shodan
  domain_info = client.get_domain_info(domain)
  # Print the domain information
  puts domain_info
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
