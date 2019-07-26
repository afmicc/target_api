if Rails.env.test?
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        address: 'New Orleans, LA, USA',
        state: 'Louisiana',
        state_code: 'LA',
        country: 'United States',
        country_code: 'US'
      }
    ]
  )
end
