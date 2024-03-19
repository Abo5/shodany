require 'shodany'
require 'json'

# Initialize with your Shodan API key
client = Shodany.new("API-T0KEN")
client = client.get_host_info("host ip e.g 192.168.10.100")
results = JSON.parse(client)
# Begin exception handling
begin
  # Retrieve host information for the specified IP
  puts "IP: #{results['ip_str']}"
  puts "Organization: #{results['org']}"
  puts "Operating System: #{results['os']}"
  puts "Ports: #{results['ports'].join(', ')}"
rescue Shodany::Error => e
  puts "An error occurred: #{e.message}"
end
