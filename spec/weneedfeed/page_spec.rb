RSpec.describe Weneedfeed::Page do
  before do
    stub_request(:get, 'http://example.com/').and_return(body: response_body)
  end

  let(:page) do
    described_class.new(
      name: 'example',
      properties: YAML.load_file('spec/fixtures/example.yml')['pages']['example'],
    )
  end

  let(:response_body) do
    File.read('spec/fixtures/example.html')
  end

  describe '#items' do
    subject do
      page.items
    end

    it 'returns items' do
      is_expected.to be_a(Array)
    end
  end
end
