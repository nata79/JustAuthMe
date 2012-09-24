class ResourcesController < ApplicationController
  simple_auth Resource, except: [:show]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
end
