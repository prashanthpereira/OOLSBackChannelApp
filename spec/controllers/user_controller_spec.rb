require 'spec_helper'

describe UsersController do
  describe "GET #index" do
    it "gets index" do
      get :index
      response.should be_redirect
    end
  end

  describe "GET #show" do
    it "shows user details" do
      get :show
      response.should be_redirect
    end
  end


end

