module ProductRakeHelpers

	def self.getcountrylist(countrystring)
		#		is_single = /\,/.match(countrystring)

		listino=countrystring.split(', ')
		#puts listino
		if listino.length>1
			return listino
		else
			return countrystring
		end
	end


end



namespace :products do

	#def self.get_countries(country_list)
	#	return Country.where(:name => 'Tanzania')
	#end

	desc "Link Images"

	task :link => :environment do

		@files = Dir["app/assets/images/imgsolarpanels/*"]

		# take each file and find the corresponding image name, match it to a product, alter the field and save
		@files.each do |file|

			
			image_name = file.split('/').last

			puts image_name

			product_name = image_name.split('.').first

			product = LightingProduct.where(:product_identifier => product_name).first
			next  if product.nil?
			puts product	
			product.update_image_url(image_name)

		end 


	end 


	desc "Load Products"
	task :load => :environment do

			require 'json'
      #require ''

			puts 'Start Ingest of Countries data'

			ingest_locations = File.new(File.join(Dir.getwd,'lib','tasks','countries.json'),'r')

			countries =  JSON.parse(ingest_locations.read())
			puts 'Mapping Events'
			mapped_countries = countries.map do|item|
				country = {
						:name => item['Country'],

				}
			end


			mapped_countries.each do|country|
				Country.create!(country)
			end
			puts "Countries Mapped"


			puts 'Start Ingest of Manufacturers data'

			ingest_locations = File.new(File.join(Dir.getwd,'lib','tasks','manufacturers.json'),'r')

			manufacturers =  JSON.parse(ingest_locations.read())
			puts 'Mapping Events'
			mapped_manufacturers = manufacturers.map do|item|
				manufacturer = {
						:name => item['Manufacturer'],
				}
			end

			mapped_manufacturers.each do|manufacturer|
				Manufacturer.create!(manufacturer)
			end
			puts "Manufacturers Mapped"


			#puts 'Start Ingest of DM data'
			ingest_locations2 = File.new(File.join(Dir.getwd,'lib','tasks','DMtable.json'),'r')

			DMcouples =  JSON.parse(ingest_locations2.read())
			#puts 'Mapping Events'
			#mapped_DMcouples = DMcouples.map do|item|
			#	distributor = {
			#			:distributor => item['Distributor'],
			#			:manifacturer => item['Manifacturer']
			#	}
			#end

			#mapped_DMcouples.each do|DMcouple|
			#	Distributor.create!(DMcouple)
			#end
			#puts "Distributors Mapped"


			puts 'Start Ingest of Distributors data'

			ingest_locations = File.new(File.join(Dir.getwd,'lib','tasks','distributors.json'),'r')

			distributors =  JSON.parse(ingest_locations.read())
			puts 'Mapping Events'
			mapped_distributors = distributors.map do|item|
			distributor = {
					:name => item['Distributor'],
					:email => item['Primary Email'],
					:address => item['Address line 1'] + ', ' + item['Address line 2'],
					:telephone => item['Primary Phone'],
					:country => Country.where(:name => item['Country']).first_or_create,
					:manufacturer => Manufacturer.where(:name => DMcouples.select{|couple| couple['Distributor'].eql? item['Distributor']}.first['Manufacturer']).first_or_create
				}
			end

			mapped_distributors.each do|distributor|
				Distributor.create!(distributor)
			end
			puts "Distributors Mapped"





	  	puts 'Start Ingest of Products data'

	  	ingest_locations = File.new(File.join(Dir.getwd,'lib','tasks','products.json'),'r')

	  	products =  JSON.parse(ingest_locations.read())
	  	puts 'Mapping Events'
			#puts get_countries('FIELD75')

			#manufacturer = Manufacturer.create!(name: "Lighting Products")

	  	mapped_products = products.map do|item|
	  		product = {
          :product_identifier => item['Product ID                   (pulled from later column from spec sheet)'],
          :name => item['Product'],
	  			:mobile_charging => item['Moblie charging'],
	  			:price => item['Price'],
	  			:num_of_lights => item['Light Points in Product'],
	  			:num_12v => item['12V power outlets'],
	  			:num_5v => item['5V USB ports'],
	  			:daily_output => item['Avaliable Daily Electrical Energy (Whday)'],
	  			:runtime => item['Run time on full battery (hours)'],
	  			:battery_capacity => item['Battery Capacity (mAmp-hours) (testing maybe needed)'],
					:system_lumens => item['Total light output (lumens)'],
				  :product_class => item['Product Class'],
				  :lamp_type => item['Lamp Type'],
				  :max_output => item['PV maximum power point (Watts)'],
					:manufacturer => Manufacturer.where(:name => item['Manufacturer']).first_or_create,
					#:manufacturer => manufacturer,
				  :product_url => item['Link to product page on manufacturer website'],
					:product_description => item['Description of light points'],
				  :countries => Country.where(:name => ProductRakeHelpers.getcountrylist(item['FIELD75'])),
				  #:distributors_id => item[''],
				  :has_stand => item['Stand']

	  			}
	  		#return product
	  	end

		puts "Products Mapped"



	  mapped_products.each do|product|
	  		LightingProduct.create!(product)
	  end

	  puts "Success, products created!!"

  end




end

