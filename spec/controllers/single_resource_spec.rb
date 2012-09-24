require "spec_helper"

describe ResourcesController do
  fixtures :resources

  it "should load resource on show, edit, update or destroy" do
    session[:user_id] = 1

    get 'show', id: resources(:resource1).id
    assigns(:resource).should eq(resources(:resource1))

    get 'edit', id: resources(:resource1).id
    assigns(:resource).should eq(resources(:resource1))

    put 'update', id: resources(:resource1).id
    assigns(:resource).should eq(resources(:resource1))

    delete 'destroy', id: resources(:resource1).id
    assigns(:resource).should eq(resources(:resource1))
  end

  it "should load all resources on index" do
    session[:user_id] = 1

    get 'index'
    assigns(:resources).should eq([resources(:resource2), resources(:resource1)])
  end

  it "should create new resource on new" do
    session[:user_id] = 1

    get 'new'
    assigns(:resource).class.should eq(Resource)
  end

  it "should create new resource on create" do
    session[:user_id] = 1

    post 'create', resource: {user_id: 1, prop: 'test'}
    assigns(:resource).class.should eq(Resource)
    assigns(:resource).user_id.should eq(1)
    assigns(:resource).prop.should eq('test')
  end

  it "should not authorize actions within except" do
    get 'show', id: resources(:resource1).id
  end

  it "should raise an exception when trying to access an anauthorized resource" do
    lambda{
      get 'edit', id: resources(:resource1).id 
    }.should raise_error(SimpleAuth::AnauthorizedAccess)

    session[:user_id] = 10

    lambda{
      get 'edit', id: resources(:resource1).id 
    }.should raise_error(SimpleAuth::AnauthorizedAccess)    
  end

  it "should not raise an exception when trying to access an anauthorized resource" do
    session[:user_id] = 1

    lambda{
      get 'edit', id: resources(:resource1).id 
    }.should_not raise_error(SimpleAuth::AnauthorizedAccess)    
  end

end