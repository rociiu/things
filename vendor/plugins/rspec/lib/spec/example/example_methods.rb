module Spec
  module Example
    module ExampleMethods
      
      extend  Spec::Example::ModuleReopeningFix
      include Spec::Example::Subject::ExampleMethods
      
      
      def violated(message="")
        raise Spec::Expectations::ExpectationNotMetError.new(message)
      end

      # Declared description for this example:
      #
      #   describe Account do
      #     it "should start with a balance of 0" do
      #     ...
      #
      #   description
      #   => "should start with a balance of 0"
      def description
        @_defined_description || ::Spec::Matchers.generated_description || "NO NAME"
      end

      # Concats the class description with the example description.
      #
      #   describe Account do
      #     it "should start with a balance of 0" do
      #     ...
      #
      #   full_description
      #   => "Account should start with a balance of 0"
      def full_description
        "#{self.class.description} #{self.description}"
      end
      
      def options # :nodoc:
        @_options
      end

      def execute(options, instance_variables) # :nodoc:
        options.reporter.example_started(self)
        set_instance_variables_from_hash(instance_variables)
        
        execution_error = nil
        Timeout.timeout(options.timeout) do
          begin
            before_each_example
            eval_block
          rescue Exception => e
            execution_error ||= e
          end
          begin
            after_each_example
          rescue Exception => e
            execution_error ||= e
          end
        end

        options.reporter.example_finished(self, execution_error)
        success = execution_error.nil? || ExamplePendingError === execution_error
      end

      def instance_variable_hash # :nodoc:
        instance_variables.inject({}) do |variable_hash, variable_name|
          variable_hash[variable_name] = instance_variable_get(variable_name)
          variable_hash
        end
      end

      def eval_each_fail_fast(blocks) # :nodoc:
        blocks.each do |block|
          instance_eval(&block)
        end
      end

      def eval_each_fail_slow(blocks) # :nodoc:
        first_exception = nil
        blocks.each do |block|
          begin
            instance_eval(&block)
          rescue Exception => e
            first_exception ||= e
          end
        end
        raise first_exception if first_exception
      end

      def set_instance_variables_from_hash(ivars) # :nodoc:
        ivars.each do |variable_name, value|
          # Ruby 1.9 requires variable.to_s on the next line
          unless ['@_implementation', '@_defined_description', '@_matcher_description', '@method_name'].include?(variable_name.to_s)
            instance_variable_set variable_name, value
          end
        end
      end

      def eval_block # :nodoc:
        instance_eval(&@_implementation)
      end

      # Provides the backtrace up to where this example was declared.
      def backtrace
        @_backtrace
      end
      
      # Deprecated - use +backtrace()+
      def implementation_backtrace
        Kernel.warn <<-WARNING
ExampleMethods#implementation_backtrace is deprecated and will be removed
from a future version. Please use ExampleMethods#backtrace instead.
WARNING
        backtrace
      end

      private
      include Matchers
      include Pending
      
      def before_each_example # :nodoc:
        setup_mocks_for_rspec
        self.class.run_before_each(self)
      end

      def after_each_example # :nodoc:
        self.class.run_after_each(self)
        verify_mocks_for_rspec
      ensure
        teardown_mocks_for_rspec
      end

      def described_class # :nodoc:
        self.class.described_class
      end
    end
  end
end
