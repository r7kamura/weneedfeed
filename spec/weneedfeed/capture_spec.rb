# frozen_string_literal: true

RSpec.describe Weneedfeed::Capture do
  before do
    stub_request(:get, 'http://example.com/').and_return(
      body: File.read(dummy_response_path)
    )
  end

  let(:dummy_response_path) do
    'spec/fixtures/example.html'
  end

  let(:schema_path) do
    'spec/fixtures/example.yml'
  end

  describe '.call' do
    subject do
      described_class.call(
        base_url: base_url,
        schema_path: schema_path
      )
    end

    let(:base_url) do
      'http://example.com'
    end

    it 'generates static files' do
      subject
      expect(File).to be_file('output/index.html')
      expect(File).to be_file('output/feeds/example')
    end
  end
end
