# frozen_string_literal: true

require_relative '../mixin/errors'

module AMA
  module Entity
    class Mapper
      class Type
        # Used as a wildcard to pass anything through
        class Any < Type
          include Mixin::Errors

          INSTANCE = new

          def attributes
            {}
          end

          def parameters
            {}
          end

          def parameter!(*)
            compliance_error('Tried to declare parameter on Any type')
          end

          def resolve_parameter(*)
            self
          end

          def map(object)
            object
          end

          def instance?(*)
            true
          end

          def satisfied_by?(*)
            true
          end

          def hash
            self.class.hash
          end

          def eql?(other)
            other.is_a?(Type)
          end

          def ==(other)
            eql?(other)
          end

          def to_s
            'Any type placeholder'
          end
        end
      end
    end
  end
end
