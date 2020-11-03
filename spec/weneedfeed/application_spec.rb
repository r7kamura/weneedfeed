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

  describe 'GET /example' do
    subject do
      get '/example'
    end

    it 'returns RSS feed' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to include('application/xml')
    end
  end
end
