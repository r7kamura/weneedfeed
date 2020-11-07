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

    context 'with ordinary situation' do
      it 'generates static files' do
        subject
        expect(File).to be_file('output/index.html')
        expect(File).to be_file('output/feeds/example_css.xml')
      end
    end

    context 'with base_url path' do
      let(:base_url) do
        "#{super()}/a"
      end

      it 'generates feed with expected link' do
        subject
        expect(File).to be_file('output/index.html')
        expect(File).to be_file('output/feeds/example_css.xml')
        expect(File.read('output/feeds/example_css.xml')).to include('http://example.com/a/feeds/example_css.xml')
      end
    end
  end
end
