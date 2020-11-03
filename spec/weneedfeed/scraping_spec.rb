# frozen_string_literal: true

require 'yaml'

RSpec.describe Weneedfeed::Scraping do
  before do
    stub_request(:get, 'http://example.com/').and_return(
      body: File.read('spec/fixtures/example.html')
    )
  end

  let(:properties) do
    YAML.load_file('spec/fixtures/example.yml')['pages']['example']
  end

  let(:scraping) do
    described_class.new(
      item_description_xpath: properties['xpath']['item_description'],
      item_link_xpath: properties['xpath']['item_link'],
      item_time_xpath: properties['xpath']['item_time'],
      item_title_xpath: properties['xpath']['item_title'],
      item_xpath: properties['xpath']['item'],
      title: properties['title'],
      url: properties['url']
    )
  end

  describe '#call' do
    subject do
      scraping.call
    end

    it 'returns page' do
      page = subject
      expect(page.items[0].description).to eq('This is episode 3.')
      expect(page.items[0].link).to eq('http://example.com/articles/01-03')
      expect(page.items[0].time).to eq(Time.new(2000, 1, 3, 0, 0, 0, '+09:00'))
      expect(page.items[0].title).to eq('Episode 3')
    end
  end
end
