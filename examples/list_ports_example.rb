# list_ports_example.rb
# Include the Shodany library
require 'shodany'

# Initialize a new Shodany client with your API key
client = Shodany.new("YOUR_API_KEY")

# Begin exception handling
begin
  # List all ports that Shodan is crawling
  ports = client.list_ports
  # Print the list of ports
  puts ports
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
