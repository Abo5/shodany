# request_scan_example.rb
# Include the Shodany library
require 'shodany'

# Initialize a new Shodany client with your API key
client = Shodany.new("YOUR_API_KEY")
# Specify the IPs to be scanned
ips = "192.168.1.1"

# Begin exception handling
begin
  # Request Shodan to scan the specified IPs
  scan_result = client.request_scan(ips)
  # Print the results of the scan
  puts scan_result
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
