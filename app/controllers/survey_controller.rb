require 'securerandom'

class SurveyController < ApplicationController
	skip_before_action :verify_authenticity_token

	def survey
		#    this method calculates which product is the best given the survey
		@survey_products = SurveyHelper.process_survey(LightingProduct.all, params[:values])
		
		# binding.pry
		respondent =  get_respondent(params) 
		

		if(!@survey_products.nil?)
			code = SecureRandom.urlsafe_base64(5).to_s
			result = SurveyResult.create(respondent: respondent, lighting_products: @survey_products, community_code: code)
			# render :json => {:result_id => result.id} if !@survey_products.nil?
			render plain:  "#{result.id} - your community code is: #{result.community_code}" if !@survey_products.nil?
		else
			render :status => 400, :json => {:error => "Bad Request"}
		end

	end


	private def get_respondent(request)
		Respondent.where(contact_name: request[:contact_name],phone: request[:phone]).first_or_create
	end
end