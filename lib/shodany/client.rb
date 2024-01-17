require_relative 'api.rb'

class ShodanyClient
  def initialize(api_key)
    raise Shodany::MissingApiKeyError, 'API key is missing or empty' if api_key.to_s.empty?
    @api = ShodanyAPI.new(api_key)
  end

  def search_exploits(query, **options)
    begin
      results = @api.search_exploits(query, **options)
      display_results(results)
    rescue Shodany::Error => e
      puts "An error occurred: #{e.message}"
    end
  end

  def get_host_info(ip, history: false, minify: false)
    info = @api.get_host_info(ip, history: history, minify: minify)
    display_results(info)
  end

  def search_shodan(query, facets = nil, page = 1, minify = true)
    results = @api.search_shodan(query, facets: facets, page: page, minify: minify)
    display_results(results)
  end
  

  def list_ports
    ports = @api.list_ports
    display_results(ports)
  end

  def request_scan(ips, services: nil)
    scan_result = @api.request_scan(ips, services: services)
    display_results(scan_result)
  end

  def get_domain_info(domain, history: false, type: nil, page: 1)
    domain_info = @api.get_domain_info(domain, history: history, type: type, page: page)
    display_results(domain_info)
  end

  private

  def display_results(results)
    # Flexible display function
    # Developers can modify this to change how results are displayed/formatted
    if results.is_a?(Hash) && results['error']
      puts "Error: #{results['error']}"
    else
      return JSON.pretty_generate(results)
    end
  end
end
