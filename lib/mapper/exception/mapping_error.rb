# frozen_string_literal: true

module AMA
  module Entity
    class Mapper
      module Exception
        # Made to be thrown whenever mapping can't be done
        class MappingError < RuntimeError
          include Exception
        end
      end
    end
  end
end
