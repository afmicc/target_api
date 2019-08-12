require 'geocoder/sql'
require 'geocoder/stores/base'

configs = { units: :km }
if Rails.env.test?
  configs[:lookup] = :test
  Geocoder.configure(configs)

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
  # Montenvideo Shopping
  Geocoder::Lookup::Test.add_stub(
    [-34.9036534, -56.1449722],
    [{
      latitude: -34.9036534,
      longitude: -56.1449722,
      address: 'Av. Dr. Luis Alberto de Herrera 1290, 11300 Montevideo, Departamento de Montevideo',
      city: 'Montevideo',
      state: 'Montevideo',
      state_code: 'IM',
      country: 'Uruguauy',
      country_code: 'UY'
    }]
  )
  # Nuevocentro Shopping
  Geocoder::Lookup::Test.add_stub(
    [-34.8756006, -56.1771999],
    [{
      latitude: -34.8756006,
      longitude: -56.1771999,
      address: 'Av. Dr. Luis Alberto de Herrera 3365, 11600 Montevideo, Departamento de Montevideo',
      city: 'Montevideo',
      state: 'Montevideo',
      state_code: 'IM',
      country: 'Uruguauy',
      country_code: 'UY'
    }]
  )
  # Rural del prado
  Geocoder::Lookup::Test.add_stub(
    [-34.8719561, -56.2144232],
    [{
      latitude: -34.8719561,
      longitude: -56.2144232,
      address: 'Av. Lucas Obes, 11700 Montevideo, Departamento de Montevideo',
      city: 'Montevideo',
      state: 'Montevideo',
      state_code: 'IM',
      country: 'Uruguauy',
      country_code: 'UY'
    }]
  )
  # Portones Shopping
  Geocoder::Lookup::Test.add_stub(
    [-34.8811386, -56.0813423],
    [{
      latitude: -34.8811386,
      longitude: -56.0813423,
      address: 'Av Italia 5775, 11500 Montevideo, Departamento de Montevideo',
      city: 'Montevideo',
      state: 'Montevideo',
      state_code: 'IM',
      country: 'Uruguauy',
      country_code: 'UY'
    }]
  )
  # Rootstrap
  Geocoder::Lookup::Test.add_stub(
    [-34.9071206, -56.2011391],
    [{
      latitude: -34.9071206,
      longitude: -56.2011391,
      address: 'Sarandí 690, 11000 Montevideo, Departamento de Montevideo',
      city: 'Montevideo',
      state: 'Montevideo',
      state_code: 'IM',
      country: 'Uruguauy',
      country_code: 'UY'
    }]
  )
else
  Geocoder.configure(configs)
end
