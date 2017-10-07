require "spec_helper"
require 'rails_helper'
require 'pry'

describe "SurveyHelper" do
  describe "process_survey" do
    it "filters the product when the country is kenya" do
      
    	first_country = Country.create(name:"kenya")
    	second_country = Country.create(name:"tanzania")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[second_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )

    	survey_params = [{:Label => 'Country', :value => "kenya" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql('first')
    end

    it "filters the product when the country is tanzania" do

    	first_country = Country.create(name:"kenya")
    	second_country = Country.create(name:"tanzania")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[second_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )

    	survey_params = [{:Label => 'Country', :value => "tanzania" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql('second')
    end 

    it "shows no products if the country is not recognised" do 
    	first_country = Country.create(name:"kenya")
    	second_country = Country.create(name:"tanzania")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[second_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )

    	survey_params = [{:Label => 'Country', :value => "blah" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result.length).to eql(0)
    end

    it "filters on the number of lights a" do 
    	first_country = Country.create(name:"kenya")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[first_country], manufacturer: manufacturer, num_of_lights: 3, num_5v: 2 )

    	survey_params = [{:Label => 'Country', :value => "kenya" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql("first")
    end

    it "filters on the number of lights c" do 
    	first_country = Country.create(name:"kenya")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[first_country], manufacturer: manufacturer, num_of_lights: 3, num_5v: 2 )

    	survey_params = [{:Label => 'Country', :value => "kenya" },{:Label => 'Number of lights', :value => "c" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql("second")
    end  

    it "filters on mobile charging required yes" do
    	first_country = Country.create(name:"kenya")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 0 )

    	survey_params = [{:Label => 'Country', :value => "kenya" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "yes" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql("first")
	end

	it "filters on mobile charging required no" do
    	first_country = Country.create(name:"kenya")
    	manufacturer = Manufacturer.create(name: "first")

    	first_product = LightingProduct.create!(name: "first", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 2 )
    	second_product = LightingProduct.create!(name: "second", countries:[first_country], manufacturer: manufacturer, num_of_lights: 1, num_5v: 0 )

    	survey_params = [{:Label => 'Country', :value => "kenya" },{:Label => 'Number of lights', :value => "a" },{:Label => 'mobile charging required', :value => "no" }]

    	result = SurveyHelper.process_survey([first_product,second_product],survey_params)	

    	expect(result[0][:name]).to eql("second")
	end		
  end
end