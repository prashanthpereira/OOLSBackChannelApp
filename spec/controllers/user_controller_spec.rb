require 'spec_helper'

describe UsersController do
  describe "GET #index" do
    it "gets index" do
      get :index
      response.should be_redirect
    end
  end

end

