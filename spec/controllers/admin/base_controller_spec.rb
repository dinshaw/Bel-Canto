require 'spec_helper'

describe Admin::BaseController do
  before(:each) do
    controller.stub!(:require_admin!)
  end
  
  describe "handling GET to index" do
    it "should render the index template" do
      get :index
      response.should render_template "index"
    end
  end
end