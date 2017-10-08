class LightingProduct < ApplicationRecord
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :distributors
  belongs_to :manufacturer


  def update_image_url(url)
  	update_attribute(:image_url, url)
  end 
end
