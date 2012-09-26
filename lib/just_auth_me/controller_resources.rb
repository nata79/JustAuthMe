module JustAuthMe
  class ControllerResources
    def self.load_on_index(resource, controller, options={}, params={})
      set_resource_object resource
      if options[:through]
        load_parent(options[:through], params, controller)
        objects = load_parent_nested_resource_collection(resource)
        controller.instance_variable_set("#{@resource_object.pluralize}", objects)
      else
        controller.instance_variable_set("#{@resource_object.pluralize}", resource.all)
      end
    end

    def self.load_on_create_or_new(resource, controller, options={}, params={})
      set_resource_object resource
      if options[:through]
        load_parent(options[:through], params, controller)
        created_object = load_parent_nested_resource_collection(resource).new(params[resource.name.underscore.to_sym])
        controller.instance_variable_set(@resource_object, created_object)
      else
        controller.instance_variable_set(@resource_object, resource.new(params[resource.name.underscore.to_sym]))
      end
    end

    def self.load_by_id(resource, controller, options={}, params={})
      set_resource_object resource
      if options[:through]
        load_parent(options[:through], params, controller)
        found_object = load_parent_nested_resource_collection(resource).find(params[:id])
        controller.instance_variable_set(@resource_object, found_object)
      else
        controller.instance_variable_set(@resource_object, resource.find(params[:id]))
      end
    end

    private
    def self.set_resource_object(resource)
      @resource_object = "@#{resource.name.underscore}"
    end

    def self.load_parent(parent_class, params, controller)
      @parent = parent_class.find(params["#{parent_class.name.underscore}_id"])
      controller.instance_variable_set("@#{parent_class.name.underscore}", @parent)
    end

    def self.load_parent_nested_resource_collection(resource)
      @parent.send("#{resource.name.underscore.pluralize}")
    end
  end
end