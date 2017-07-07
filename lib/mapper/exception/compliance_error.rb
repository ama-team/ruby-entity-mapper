# frozen_string_literal: true

module AMA
  module Entity
    class Mapper
      module Exception
        # This exception is supposed to be thrown whenever end user provides
        # malformed input - too many types, not enough types, not a type, etc.
        class ComplianceError < RuntimeError
        end
      end
    end
  end
end
