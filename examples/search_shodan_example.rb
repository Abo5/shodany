# search_shodan_example.rb
# Include the Shodany library
require 'shodany'

# Initialize a new Shodany client with your API key
client = Shodany.new("YOUR_API_KEY")
# Define your search query
query = "server:apache country:DE"

# Begin exception handling
begin
  # Perform a general search on Shodan with the query
  results = client.search_shodan(query)
  # Print the search results
  puts results
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
