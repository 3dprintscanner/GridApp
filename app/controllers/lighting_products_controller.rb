class LightingProductsController < ApplicationController
  before_action :set_lighting_product, only: [:show]

  # GET /lighting_products
  # GET /lighting_products.json
  def index
    @lighting_products = LightingProduct.all
  end

  # GET /lighting_products/1
  # GET /lighting_products/1.json
  def show
  end

  def recommended_products
    @lighting_products = LightingProduct.get_recommended(survey_form_params)
  end

   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lighting_product
      @lighting_product = LightingProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lighting_product_params
      params.require(:lighting_product).permit(:index, :show)
    end


    def survey_form_params
       params.require(:lighting_product).permit(:index, :show) 
    end
end
