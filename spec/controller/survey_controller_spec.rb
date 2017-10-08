require "spec_helper"
require 'rails_helper'
require 'json'


describe "SurveyController", :type => :controller do
  before(:each) do
    @controller = SurveyController.new
  end


  describe "POST survey" do
    it "has a 400 status code when there is no request body" do
      post :survey
      expect(response.status).to eq(400)
    end

    it "has a 400 status code when there is am incorrect request body " do
    	post :survey, :params => { :wrongvalues => [
    		{ :val => "someval"  }
    		] }

    	expect(response.status).to eq(400)
    end


    it "responds with a 200 code for requests with the right form" do
    	post :survey, :params => { :values => [
    		{ :val => "someval"  }
    		] }

    	expect(response.status).to eq(200)
    end



    it "creates a new respondent from the results" do
      post :survey, :params => {:contact_name => "testname", :phone => "12323123", :values => [{:val => "someval"}]}

      
      expect(JSON.parse(response.body)['result_id']).to be_an(Integer)

    end 
  end
end