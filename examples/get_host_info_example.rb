# get_host_info_example.rb
# Include the Shodany library
require 'shodany'

# Initialize a new Shodany client with your API key
client = Shodany.new("YOUR_API_KEY")
# Specify the IP address you want information about
ip = "8.8.8.8"

# Begin exception handling
begin
  # Retrieve host information for the specified IP
  info = client.get_host_info(ip)
  # Print the retrieved information
  puts info
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
