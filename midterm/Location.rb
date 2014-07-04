class Location
	attr_accessor :locality, :result, :props_hash

	def initialize(google_maps_api_hash)
		@props_hash = google_maps_api_hash
		@result = set_properties
	end

	def set_properties
		result = {}
		@props_hash['results'][0]['address_components'].each{
			|level|
			result[level['types'][0]] = level['long_name']
			}
		result
	end

	def to_s
		s= ""
		self.result.each{|k,v|
			s+= "\t#{k} = #{v}\n"
		}
		s
	end
end
