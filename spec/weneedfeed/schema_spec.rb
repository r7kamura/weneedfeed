# frozen_string_literal: true

RSpec.describe Weneedfeed::Schema do
  describe '.load_file' do
    subject do
      described_class.load_file(schema_path)
    end

    let(:schema_path) do
      File.expand_path('../fixtures/example.yml', __dir__)
    end

    it 'returns a Weneedfeed::Schema' do
      is_expected.to be_a(described_class)
    end
  end
end
