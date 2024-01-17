# spec/shodany_spec.rb

require 'spec_helper'
require_relative '../lib/shodany/api'
require 'webmock/rspec'

RSpec.describe ShodanyAPI do
  let(:api_key) { 'API-TOKEN' }
  let(:shodany_api) { ShodanyAPI.new(api_key) }

  before do
    stub_request(:any, /api.shodan.io/).to_return(status: 200, body: '{}', headers: {})
    stub_request(:any, /exploits.shodan.io/).to_return(status: 200, body: '{}', headers: {})
  end

  describe '#initialize' do
    context 'with valid API key' do
      it 'initializes the ShodanyAPI' do
        expect(shodany_api).to be_a(ShodanyAPI)
      end
    end

    context 'with missing API key' do
      let(:api_key) { nil }
      it 'raises MissingApiKeyError' do
        expect { ShodanyAPI.new(api_key) }.to raise_error(Shodany::MissingApiKeyError)
      end
    end
  end

  describe '#search_exploits' do
    context 'with valid query' do
      it 'returns exploits based on query' do
        stub_request(:get, /exploits.shodan.io/).to_return(status: 200, body: '{"matches": [{"key": "value"}]}', headers: {})
        results = shodany_api.search_exploits('example_query')
        expect(results['matches']).not_to be_empty
      end
    end

    context 'with invalid parameters' do
      it 'returns an empty result' do
        stub_request(:get, /exploits.shodan.io/).to_return(status: 200, body: '{"matches": []}', headers: {})
        expect(shodany_api.search_exploits('')).to eq('matches' => [])
      end
    end
  end

    describe '#get_host_info' do
      context 'with invalid IP' do
        it 'returns an error message for invalid IP' do
          stub_request(:get, /api.shodan.io/).to_return(status: 200, body: '{"error": "Not Found"}', headers: {})
          expect { shodany_api.get_host_info('8.8.8.8') }.to raise_error(Shodany::NotFoundError, "Not Found")
        end
      end
    end
    

  describe '#search_shodan' do
    context 'with valid query' do
      it 'performs a general search on Shodan' do
        stub_request(:get, /api.shodan.io/).to_return(status: 200, body: '{"matches": [{"key": "value"}]}', headers: {})
        results = shodany_api.search_shodan('webcam')
        expect(results['matches']).not_to be_empty
      end
    end

    context 'with network issues' do
      it 'handles network timeouts' do
        stub_request(:get, /api.shodan.io/).to_timeout
        expect { shodany_api.search_shodan('webcam') }.to raise_error(Net::OpenTimeout)
      end
    end
  end

  describe '#list_ports' do
    it 'lists all ports that Shodan is crawling on' do
      stub_request(:get, /api.shodan.io/).to_return(status: 200, body: '[80, 443]', headers: {})
      ports = shodany_api.list_ports
      expect(ports).to match_array([80, 443])
    end
  end

  describe '#request_scan' do
    context 'with valid IP' do
      it 'requests Shodan to scan a given IP or netblock' do
        stub_request(:post, /api.shodan.io/).to_return(status: 200, body: '{"id": "scan_id"}', headers: {})
        scan_result = shodany_api.request_scan('8.8.8.8')
        expect(scan_result).to include('id')
      end
    end

    context 'with invalid IP' do
      it 'handles invalid IPs for scanning' do
        stub_request(:post, /api.shodan.io/).to_return(status: 400, body: '{"error": "Bad Request"}', headers: {})
        expect { shodany_api.request_scan('invalid_ip') }.to raise_error(Shodany::InvalidResponseError)
      end
    end
  end

  describe '#get_domain_info' do
    context 'with valid domain' do
      it 'gets information for a specific domain' do
        stub_request(:get, /api.shodan.io/).to_return(status: 200, body: '{"domain": "example.com", "data": []}', headers: {})
        domain_info = shodany_api.get_domain_info('example.com')
        expect(domain_info).to include('domain')
      end
    end

    context 'with invalid domain' do
      it 'handles invalid domains' do
        stub_request(:get, /api.shodan.io/).to_return(status: 404, body: '{"error": "Not Found"}', headers: {})
        expect { shodany_api.get_domain_info('invalid_domain') }.to raise_error(Shodany::NotFoundError)
      end
    end
  end
end