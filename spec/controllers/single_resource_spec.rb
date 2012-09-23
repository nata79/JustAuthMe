require "spec_helper"

describe ResourcesController do
  fixtures :resources

  it "should load resource" do
    get 'show', id: resources(:resource1).id
    assigns(:resource).should eq(resources(:resource1))
  end

end