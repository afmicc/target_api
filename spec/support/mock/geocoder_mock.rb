module Support
  module Mock
    class GeocoderMock
      def self.add_stub_worthington(latitude, longitude)
        Geocoder::Lookup::Test.add_stub([latitude, longitude],
                                        worthington_data(latitude, longitude))
      end

      def self.add_stub_new_york(latitude, longitude)
        Geocoder::Lookup::Test.add_stub([latitude, longitude],
                                        new_york_data(latitude, longitude))
      end

      def self.add_stub_new_orleans(latitude, longitude)
        Geocoder::Lookup::Test.add_stub([latitude, longitude],
                                        new_orleans_data(latitude, longitude))
      end

      def self.worthington_data(latitude, longitude)
        [{
          latitude: latitude,
          longitude: longitude,
          address: 'Worthington, OH',
          city: 'Worthington',
          state: 'Ohio',
          state_code: 'OH',
          country: 'United States',
          country_code: 'US'
        }]
      end

      def self.new_york_data(latitude, longitude)
        [{
          latitude: latitude,
          longitude: longitude,
          address: 'New York, NY, USA',
          state: 'New York',
          state_code: 'NY',
          country: 'United States',
          country_code: 'US'
        }]
      end

      def self.new_orleans_data(latitude, longitude)
        [{
          latitude: latitude,
          longitude: longitude,
          address: 'New Orleans, LA, USA',
          state: 'Louisiana',
          state_code: 'LA',
          country: 'United States',
          country_code: 'US'
        }]
      end
    end
  end
end
