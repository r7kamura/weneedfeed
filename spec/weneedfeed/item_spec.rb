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

  describe '#image_mime_type' do
    subject do
      item.image_mime_type
    end

    context 'when img element is not found' do
      let(:node_raw) do
        ''
      end

      it 'returns nil' do
        is_expected.to eq(nil)
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
        is_expected.to eq(nil)
      end
    end

    context 'when img element is found' do
      it 'returns its src' do
        is_expected.to eq('http://example.com/example1.jpg')
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

      it 'returns a Time of 2000-01-01 00:00:00 in +09:00' do
        is_expected.to eq(Time.new(2000, 1, 1, 0, 0, 0, '+09:00'))
      end
    end

    context 'with 2000-01-01' do
      let(:node_raw) do
        '<time>2000-01-01</time>'
      end

      it 'returns a Time of 2000-01-01 00:00:00 in local time zone' do
        is_expected.to eq(Time.new(2000, 1, 1))
      end
    end

    context 'with 2000年1月1日' do
      let(:node_raw) do
        '<time>2000年1月1日</time>'
      end

      it 'returns a Time of 2000-01-01 00:00:00 in local time zone' do
        is_expected.to eq(Time.new(2000, 1, 1))
      end
    end
  end
end
