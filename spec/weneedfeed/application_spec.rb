# frozen_string_literal: true

RSpec.describe Weneedfeed::Application do
  include Rack::Test::Methods

  before do
    stub_request(:get, 'http://example.com/').and_return(
      body: File.read('spec/fixtures/example.html')
    )
  end

  let(:app) do
    described_class.new(
      schema: YAML.load_file('spec/fixtures/example.yml')
    )
  end

  describe 'GET /' do
    subject do
      get '/'
    end

    it 'returns HTML page' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to include('text/html')
    end
  end

  describe 'GET /feeds/example_css.xml' do
    subject do
      get '/feeds/example_css.xml'
    end

    it 'returns RSS feed' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to include('application/xml')
    end
  end

  describe 'GET /feeds/example_xpath.xml' do
    subject do
      get '/feeds/example_xpath.xml'
    end

    it 'returns RSS feed' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to include('application/xml')
    end
  end
end
