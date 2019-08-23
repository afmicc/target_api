json.id           target.id
json.user_id      target.user_id
json.area_lenght  target.area_lenght
json.title        target.title
json.latitude     target.latitude
json.longitude    target.longitude
json.topic        target.topic, partial: 'api/v1/topics/info', as: :topic
