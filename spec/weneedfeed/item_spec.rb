# frozen_string_literal: true

require 'nokogiri'

RSpec.describe Weneedfeed::Item do
  let(:item) do
    described_class.new(
      description_selector: 'p:nth-child(3)',
      image_selector: 'img',
      link_selector: 'a',
      node: node,
      time_selector: 'time',
      title_selector: 'p:nth-child(2)',
      url: 'http://example.com'
    )
  end

  let(:node) do
    Nokogiri::HTML.fragment(node_raw)
  end

  let(:node_raw) do
    <<~HTML
      <p><time datetime="2000-01-01T00:00:00+09:00">2000-01-01</time></p>
      <p><a href="/articles/01-01">Episode 1</a></p>
      <p>This is episode 1.</p>
      <img src="/example1.jpg"/>
    HTML
  end

  describe '#guid' do
    subject do
      item.guid
    end

    context 'when link is found' do
      it 'returns link' do
        is_expected.to eq(item.link)
      end
    end

    context 'when link is not found' do
      let(:node_raw) do
        ''
      end

      it 'returns sha1' do
        is_expected.to eq('urn:sha1:05a79f06cf3f67f726dae68d18a2290f6c9a50c9')
      end
    end
  end

  describe '#image_mime_type' do
    subject do
      item.image_mime_type
    end

    context 'when img element is not found' do
      let(:node_raw) do
        ''
      end

      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'when img element is found' do
      it 'returns its MIME type' do
        is_expected.to eq('image/jpeg')
      end
    end
  end

  describe '#image_url' do
    subject do
      item.image_url
    end

    context 'when img element is not found' do
      let(:node_raw) do
        ''
      end

      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'when img element is found' do
      it 'returns its src' do
        is_expected.to eq('http://example.com/example1.jpg')
      end
    end

    context 'when img element URL has invalid format' do
      let(:node_raw) do
        '<img src="/a b.jpg"/>'
      end

      it 'returns normalized URL' do
        is_expected.to eq('http://example.com/a%20b.jpg')
      end
    end
  end

  describe '#link' do
    subject do
      item.link
    end

    context 'when link is not found' do
      let(:node_raw) do
        ''
      end

      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'when link is found' do
      it 'returns absolute URL' do
        is_expected.to eq('http://example.com/articles/01-01')
      end
    end

    context 'when link URL has invalid format' do
      let(:node_raw) do
        '<a href="/a b">dummy</a>'
      end

      it 'returns normalized URL' do
        is_expected.to eq('http://example.com/a%20b')
      end
    end
  end

  describe '#time' do
    subject do
      item.time
    end

    context 'with 2000-01-01T00:00:00+09:00 datetime attribute and 2000-01-02 inner HTML' do
      let(:node_raw) do
        '<time datetime="2000-01-01T00:00:00+09:00">2000-01-02</time>'
      end

      it 'returns expected time' do
        is_expected.to eq(Time.new(2000, 1, 1, 0, 0, 0, '+09:00'))
      end
    end

    context 'with 2000-01-01' do
      let(:node_raw) do
        '<time>2000-01-01</time>'
      end

      it 'returns expected time' do
        is_expected.to eq(Time.new(2000, 1, 1))
      end
    end

    context 'with 2000年1月1日' do
      let(:node_raw) do
        '<time>2000年1月1日</time>'
      end

      it 'returns expected time' do
        is_expected.to eq(Time.new(2000, 1, 1))
      end
    end

    context 'with 1月1日' do
      let(:node_raw) do
        '<time>1月1日</time>'
      end

      it 'returns expected Time' do
        is_expected.to eq(Time.new(Time.now.year, 1, 1))
      end
    end

    context 'with 12月31日' do
      let(:node_raw) do
        '<time>12月31日</time>'
      end

      it 'returns expected Time' do
        is_expected.to eq(Time.new(Time.now.year - 1, 12, 31))
      end
    end

    context 'with 1月1日配信' do
      let(:node_raw) do
        '<time>1月1日配信</time>'
      end

      it 'returns expected Time' do
        is_expected.to eq(Time.new(Time.now.year, 1, 1))
      end
    end
  end
end
