require "spec_helper"

describe NestedResourcesController do
  fixtures :parent_resources
  fixtures :nested_resources

  it "should load resource on show, edit, update or destroy" do
    session[:user_id] = 1

    get 'show', parent_resource_id: parent_resources(:parent_resource1).id, id: nested_resources(:nested_resource1).id
    assigns(:nested_resource).should eq(nested_resources(:nested_resource1))
    assigns(:parent_resource).should eq(parent_resources(:parent_resource1))

    get 'edit', parent_resource_id: parent_resources(:parent_resource1).id, id: nested_resources(:nested_resource1).id
    assigns(:nested_resource).should eq(nested_resources(:nested_resource1))
    assigns(:parent_resource).should eq(parent_resources(:parent_resource1))

    put 'update', parent_resource_id: parent_resources(:parent_resource1).id, id: nested_resources(:nested_resource1).id
    assigns(:nested_resource).should eq(nested_resources(:nested_resource1))
    assigns(:parent_resource).should eq(parent_resources(:parent_resource1))

    delete 'destroy', parent_resource_id: parent_resources(:parent_resource1).id, id: nested_resources(:nested_resource1).id
    assigns(:nested_resource).should eq(nested_resources(:nested_resource1))
    assigns(:parent_resource).should eq(parent_resources(:parent_resource1))
  end

  it "should load all resources on index" do
    session[:user_id] = 1

    get 'index', parent_resource_id: parent_resources(:parent_resource1).id
    assigns(:nested_resources).should eq([nested_resources(:nested_resource1)])
  end

  it "should create new resource on new" do
    session[:user_id] = 1

    get 'new', parent_resource_id: parent_resources(:parent_resource1).id
    assigns(:nested_resource).class.should eq(NestedResource)
    assigns(:nested_resource).parent_resource.should eq(parent_resources(:parent_resource1))
  end

  it "should create new resource on create" do
    session[:user_id] = 1

    post 'create', nested_resource: {prop: 'test'}, parent_resource_id: parent_resources(:parent_resource1).id
    assigns(:nested_resource).class.should eq(NestedResource)
    assigns(:nested_resource).prop.should eq('test')
    assigns(:nested_resource).parent_resource.should eq(parent_resources(:parent_resource1))
  end

  # it "should not authorize actions within except" do
  #   get 'show', id: resources(:resource1).id
  # end

  # it "should raise an exception when trying to access an anauthorized resource" do
  #   lambda{
  #     get 'edit', id: resources(:resource1).id 
  #   }.should raise_error(SimpleAuth::AnauthorizedAccess)

  #   session[:user_id] = 10

  #   lambda{
  #     get 'edit', id: resources(:resource1).id 
  #   }.should raise_error(SimpleAuth::AnauthorizedAccess)    
  # end

  # it "should not raise an exception when trying to access an anauthorized resource" do
  #   session[:user_id] = 1

  #   lambda{
  #     get 'edit', id: resources(:resource1).id 
  #   }.should_not raise_error(SimpleAuth::AnauthorizedAccess)    
  # end

end