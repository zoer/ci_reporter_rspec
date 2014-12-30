module CI::Reporter
  module RSpec2
    #
    # Расширяем struct, добавляем namespace атриубут.
    #   Необходимо для корректного оторбажения группы тестов в Jenkins
    #
    class TestCase < CI::Reporter::TestCase
      def initialize(example)
        @classname = "#{root_namespace}." +
          example.file_path.gsub(/_spec\.rb$/,"") .gsub(/^.*\/spec\//,"")
          .split("/").first
        super()
      end

      def root_namespace
        ENV['CI_REPORTER_NAMESPACE'] || "unnamed"
      end

      def values
        super << @classname
      end

      def members
        super << :classname
      end
    end
  end
end
