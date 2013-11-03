require 'spec_helper'

describe TeamsController do

  describe "GET 'members'" do
    it "returns http success" do
      get 'members'
      response.should be_success
    end
  end

  describe "GET 'checklists'" do
    it "returns http success" do
      get 'checklists'
      response.should be_success
    end
  end

end
