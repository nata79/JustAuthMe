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
          
          if options[:through]
            auth_object = "@#{options[:through].name.underscore}"
          else
            auth_object = "@#{resource.name.underscore}"
          end

          send :define_method, "load_#{resource.name.underscore}_simple_auth" do

            # Load resource
            if params[:action] == 'index'
              SimpleAuth::ControllerResources.load_on_index(resource, self, options, params)
            elsif params[:action] == 'create'
              SimpleAuth::ControllerResources.load_on_create_or_new(resource, self, options, params)
            elsif params[:action] == 'new'
              SimpleAuth::ControllerResources.load_on_create_or_new(resource, self, options, params)
            else
              SimpleAuth::ControllerResources.load_by_id(resource, self, options, params)
            end

          end

          before_filter "load_#{resource.name.underscore}_simple_auth".to_sym

          send :define_method, "authorize_#{resource.name.underscore}_simple_auth" do

            # Authorize resource
            raise SimpleAuth::AnauthorizedAccess unless current_user

            if (params[:action] != 'index'  and 
                params[:action] != 'create' and 
                params[:action] != 'new'    and 
                instance_variable_defined?(auth_object))

              raise SimpleAuth::AnauthorizedAccess unless current_user.id == instance_variable_get(auth_object).user_id
            end

          end

          before_filter "authorize_#{resource.name.underscore}_simple_auth".to_sym, only: options[:only], except: options[:except]

        end
      end


      module InstanceMethods
        
      end

    end

  end

end
::ActionController::Base.send :include, SimpleAuth::ControllerAdditions::Controller