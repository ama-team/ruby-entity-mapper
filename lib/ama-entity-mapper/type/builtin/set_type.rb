# frozen_string_literal: true

require 'set'

require_relative '../../type'
require_relative '../../path/segment'
require_relative '../../mixin/errors'

module AMA
  module Entity
    class Mapper
      class Type
        module BuiltIn
          # Predefined type for Set class
          class SetType < Type
            def initialize
              super(::Set)
              attribute!(:_value, parameter!(:T), virtual: true)

              define_factory
              define_normalizer
              define_denormalizer
              define_enumerator
              define_injector
            end

            private

            def define_factory
              factory_block do |*|
                Set.new([])
              end
            end

            def define_normalizer
              normalizer_block do |input, *|
                input.map(&:itself)
              end
            end

            def define_denormalizer
              denormalizer_block do |data, type, context = nil, *|
                if data.is_a?(Hash) || !data.is_a?(Enumerable)
                  message = "Can't denormalize Set from #{data.class}"
                  type.mapping_error(message, context: context)
                end
                Set.new(data)
              end
            end

            def define_enumerator
              enumerator_block do |entity, type, *|
                ::Enumerator.new do |yielder|
                  attribute = type.attributes[:_value]
                  entity.each_with_index do |value, index|
                    yielder << [attribute, value, Path::Segment.index(index)]
                  end
                end
              end
            end

            def define_injector
              injector_block do |entity, _, _, value, *|
                entity.add(value)
              end
            end

            INSTANCE = new
          end
        end
      end
    end
  end
end
