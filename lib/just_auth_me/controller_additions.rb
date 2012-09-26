module JustAuthMe
  module ControllerAdditions

    module Controller
      def self.included(klass)
        klass.class_eval do
          self.send :extend, JustAuthMe::ControllerAdditions::Controller::ClassMethods
        end
      end

      module ClassMethods        

        def just_auth_me(resource, options={})
          
          if options[:through]
            auth_object = "@#{options[:through].name.underscore}"
          else
            auth_object = "@#{resource.name.underscore}"
          end

          send :define_method, "load_#{resource.name.underscore}_just_auth_me" do

            # Load resource
            if params[:action] == 'index'
              JustAuthMe::ControllerResources.load_on_index(resource, self, options, params)
            elsif params[:action] == 'create'
              JustAuthMe::ControllerResources.load_on_create_or_new(resource, self, options, params)
            elsif params[:action] == 'new'
              JustAuthMe::ControllerResources.load_on_create_or_new(resource, self, options, params)
            else
              JustAuthMe::ControllerResources.load_by_id(resource, self, options, params)
            end

          end

          before_filter "load_#{resource.name.underscore}_just_auth_me".to_sym

          send :define_method, "authorize_#{resource.name.underscore}_just_auth_me" do

            # Authorize resource
            raise JustAuthMe::AnauthorizedAccess unless current_user

            if (params[:action] != 'index'  and 
                params[:action] != 'create' and 
                params[:action] != 'new'    and 
                instance_variable_defined?(auth_object))

              raise JustAuthMe::AnauthorizedAccess unless current_user.id == instance_variable_get(auth_object).user_id
            end

          end

          before_filter "authorize_#{resource.name.underscore}_just_auth_me".to_sym, only: options[:only], except: options[:except]

        end
      end


      module InstanceMethods
        
      end

    end

  end

end
::ActionController::Base.send :include, JustAuthMe::ControllerAdditions::Controller