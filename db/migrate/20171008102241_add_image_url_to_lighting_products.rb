class AddImageUrlToLightingProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :lighting_products, :image_url, :string
  end
end
