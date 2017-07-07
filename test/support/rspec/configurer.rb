# frozen_string_literal: true

require 'rspec'
require 'allure-rspec'
require 'coveralls'

module AMA
  module Entity
    class Mapper
      module Test
        module RSpec
          class Configurer
            class << self
              def configure(test_type)
                Coveralls.wear!
                ::RSpec.configure do |config|
                  # Enable flags like --only-failures and --next-failure
                  path = 'test/metadata/rspec/status'
                  config.example_status_persistence_file_path = path

                  config.expect_with :rspec do |c|
                    c.syntax = :expect
                  end

                  configure_allure(config, test_type)

                  yield(config) if block_given?
                end
              end

              private

              def configure_allure(rspec_config, test_type)
                rspec_config.include ::AllureRSpec::Adaptor
                ::AllureRSpec.configure do |allure|
                  allure.output_dir = "test/metadata/allure/#{test_type}"
                  allure.logging_level = Logger::INFO
                end
              end
            end
          end
        end
      end
    end
  end
end