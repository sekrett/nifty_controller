require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class Rails::NiftyControllerGenerator < Rails::Generators::NamedBase
      include ResourceHelpers

      source_root File.expand_path('../templates', __FILE__)

      check_class_collision :suffix => "Controller"

      class_option :orm, :banner => "NAME", :type => :string, :required => true,
                   :desc => "ORM to generate the controller for"
      class_option :with_cancan, :aliases => '-c', :type => :boolean, :default => false,
                   :desc => "Use CanCan load_resource"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end

      hook_for :template_engine, :test_framework, :as => :scaffold

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, :as => :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end

      no_tasks do
        def with_cancan
          orm_class.all(class_name)
          options.with_cancan?
        end
      end
    end
  end
end
