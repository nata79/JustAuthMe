class NestedResourcesController < ApplicationController
  just_auth_me NestedResource, through: ParentResource, except: [:show]
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create  
    if @nested_resource.save
      redirect_to parent_resource_nested_resource_url(@parent_resource, @nested_resource), notice: 'Nested resource was successfully created.'
    else
      render action: "new"      
    end
  end

  def update
    if @nested_resource.update_attributes(params[:nested_resource])
      redirect_to [@parent_resource, @nested_resource], notice: 'Nested resource was successfully updated.'
    else
      render action: "edit"        
    end
  end

  def destroy  
    @nested_resource.destroy
    
    redirect_to parent_resource_nested_resources_url(@nested_resource)
  end
end
