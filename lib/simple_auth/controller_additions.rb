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
          
          auth_object = "@#{resource.name.underscore}"

          send :define_method, "load_#{resource.name.underscore}_simple_auth" do

            # Load resource
            if params[:action] == 'index'
              instance_variable_set("#{auth_object.pluralize}", resource.all)
            elsif params[:action] == 'create'
              instance_variable_set(auth_object, resource.new(params[resource.name.underscore.to_sym]))
            elsif params[:action] == 'new'
              instance_variable_set(auth_object, resource.new(params["#{resource.name.underscore}".to_sym]))
            else
              instance_variable_set(auth_object, resource.find(params[:id])) if params[:id]
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