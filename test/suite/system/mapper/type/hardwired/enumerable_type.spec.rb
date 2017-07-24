# frozen_string_literal: true

require_relative '../../../../../../lib/mapper/type/hardwired/enumerable_type'
require_relative '../../../../../../lib/mapper/path/segment'
require_relative '../../../../../../lib/mapper/exception/mapping_error'

klass = ::AMA::Entity::Mapper::Type::Hardwired::EnumerableType
segment_class = ::AMA::Entity::Mapper::Path::Segment
mapping_error_class = ::AMA::Entity::Mapper::Exception::MappingError

describe klass do
  let(:type) do
    klass::INSTANCE
  end

  describe '#normalizer' do
    it 'should provide convert-to-array normalizer' do
      data = [1, 2, 3]
      expect(type.normalizer.call(data)).to eq(data)
    end
  end

  describe '#denormalizer' do
    it 'should provide pass-through denormalizer' do
      data = [1, 2, 3]
      expect(type.denormalizer.call(data)).to eq(data)
    end
  end

  describe '#enumerator' do
    it 'should provide default enumerator' do
      source = [1, 2, 3]
      attribute = type.attributes[:_value]
      proc = lambda do |consumer|
        type.enumerator(source).each(&consumer)
      end
      expectations = source.each_with_index.map do |item, index|
        [attribute, item, segment_class.index(index)]
      end
      expect(&proc).to yield_successive_args(*expectations)
    end
  end

  describe '#acceptor' do
    it 'should provide default acceptor' do
      target = []
      expectation = [1, 2, 3]
      acceptor = type.acceptor(target)
      attribute = type.attributes[:_value]
      expectation.each_with_index.map do |value, index|
        acceptor.accept(attribute, value, segment_class.index(index))
      end
      expect(target).to eq(expectation)
    end
  end

  describe '#extractor' do
    it 'should provide default extractor' do
      source = [1, 2, 3]
      attribute = type.attributes[:_value]
      expectations = source.each_with_index.map do |value, index|
        [attribute, value, segment_class.index(index)]
      end
      proc = lambda do |consumer|
        type.extractor(source).each(&consumer)
      end
      expect(&proc).to yield_successive_args(*expectations)
    end

    it 'should provide extractor not accepting anything but enumerable' do
      proc = lambda do
        type.extractor(double)
      end
      expect(&proc).to raise_error(mapping_error_class)
    end
  end
end