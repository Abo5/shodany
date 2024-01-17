# lib/shodany/api.rb
require_relative 'error.rb'
require 'net/http'
require 'json'

class ShodanyAPI # Defines the ShodanyAPI class for interacting with the Shodan API.
  BASE_URL = 'https://api.shodan.io/' # Base URLs for the Shodan API and the Exploits API.
  EXPLOITS_BASE_URL = 'https://exploits.shodan.io/api'
  
    
  def initialize(api_key) # Initialize the API with the user's API key.
    raise Shodany::MissingApiKeyError, 'API key is missing or empty' if api_key.to_s.empty?     # Raise an error if the API key is missing or empty.
    @api_key = api_key
  end

  # Search for exploits in the Shodan Exploits database.
  # Search for exploits
  # Accepts various parameters for filtering the search.
  def search_exploits(query, author: nil, bid: nil, code: nil, cve: nil, date: nil, description: nil, msb: nil, osvdb: nil, platform: nil, port: nil, title: nil, type: nil, facets: nil, page: 1)
    params = { # Base parameters for the search query.
      query: query,
      key: @api_key,
      page: page
    }
    
    additional_params = { author: author, bid: bid, code: code, cve: cve, date: date, description: description, msb: msb, osvdb: osvdb, platform: platform, port: port, title: title, type: type, facets: facets } # Additional filtering parameters.
    additional_params.each { |key, value| params[key] = value if value } # Add non-nil additional parameters to the base parameters.

    uri = URI(EXPLOITS_BASE_URL + "/search?#{URI.encode_www_form(params)}") # Construct the request URI with the query parameters.
    
    begin # Perform the HTTP GET request and handle exceptions.
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)
      raise Shodany::InvalidResponseError, result['error'] if result.key?('error') # Raise an error if the response contains an error message.
      result
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format' # Raise an error for invalid response format.
    end
  end



  # Retrieve host information
  # ip means: host you want to get info about it e.g ("8.8.8.8")
  # history means: 
  def get_host_info(ip, history: false, minify: false)
    uri = URI("#{BASE_URL}/shodan/host/#{ip}?key=#{@api_key}&history=#{history}&minify=#{minify}")
    
    begin
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)
      raise Shodany::NotFoundError, result['error'] if result.key?('error')
      result
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format'
    end
  end


  # Search Shodan for anything 
  # query means: [String] Shodan search query. The provided string is used to search the database of banners in Shodan, with the additional option to provide filters inside the search query using a "filter:value" format. For example, the following search query would find Apache Web servers located in Germany: "apache country:DE"
  # facets means: [string] "US" or "SA"  
  # page means: number of page e.g 1 or 2... 
  # minify means: [Boolean] True or False; whether or not to truncate some of the larger fields (default: True)
  def search_shodan(query, facets: nil, page: 1, minify: true)
    params = {
      key: @api_key,
      query: query,
      page: page,
      minify: minify
    }
    params[:facets] = facets if facets
  
    uri = URI("#{BASE_URL}/shodan/host/search?#{URI.encode_www_form(params)}")
  
    begin
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)
      raise Shodany::InvalidResponseError, result['error'] if result.key?('error')
      result
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format'
    end
  end
  


  # List all ports .. This method returns a list of port numbers that the crawlers are looking for.
  def list_ports
    uri = URI("#{BASE_URL}/shodan/ports?key=#{@api_key}")
    
    begin
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format'
    end
  end


  # Request Shodan to crawl an IP/ netblock
  def request_scan(ips, services: nil)
    uri = URI("#{BASE_URL}/shodan/scan?key=#{@api_key}")
    data = { ips: ips, services: services }.to_json

    begin
      response = Net::HTTP.post(uri, data, "Content-Type" => "application/json")
      result = JSON.parse(response.body)
      raise Shodany::InvalidResponseError, result['error'] if result.key?('error')
      result
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format'
    end
  end


  # Get domain information
  def get_domain_info(domain, history: false, type: nil, page: 1)
    uri = URI("#{BASE_URL}/dns/domain/#{domain}?key=#{@api_key}&history=#{history}&type=#{type}&page=#{page}")

    begin
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)
      raise Shodany::NotFoundError, result['error'] if result.key?('error')
      result
    rescue JSON::ParserError
      raise Shodany::InvalidResponseError, 'Invalid response format'
    end
  end
end