module SendGrid
	module WebAPI
		
		#Connection
		def self.conn
			@conn ||= create_conn
		end

		def self.create_conn
			@conn = Faraday.new(:url => 'https://sendgrid.com') do |faraday|
	  			faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
			end
		end

		#Authentication
		def self.api_user=(api_user)
			@api_user = api_user
		end
		def self.api_user
			@api_user
		end
		def self.api_key=(api_key)
			@api_key = api_key
		end
		def self.api_key
			@api_key
		end
		def self.add_auth_params(hash)
			hash.merge(api_user:api_user,api_key:api_key)
		end

		#API Methods
		def self.unsubscribes(params={})
			params[:date] = 1 unless params.include?(:date)
			response = conn.get do |req|                         
				req.url '/api/unsubscribes.get.json',add_auth_params(params)
			end
			response.body
		end

	end
end	