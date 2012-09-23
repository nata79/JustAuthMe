module SimpleAuth
  module ControllerAdditions

    module Controller
      def self.included(klass)
        klass.class_eval do
          self.send :extend, SimpleAuth::ControllerAdditions::Controller::ClassMethods
        end
      end

      module ClassMethods        
        def simple_auth(resource, options={})
        
        end
      end


      module InstanceMethods
        
      end

    end

  end

end
::ActionController::Base.send :include, SimpleAuth::ControllerAdditions::Controller