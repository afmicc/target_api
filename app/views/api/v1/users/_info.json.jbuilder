json.id       user.id
json.email    user.email
json.name     user.name
json.gender   user.gender
json.avatar   polymorphic_url(user.avatar) if user.avatar.attached?
