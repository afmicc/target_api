json.id             chat_room.id
json.title          chat_room.title
json.user_owner_id  chat_room.user_owner_id
json.user_guest_id  chat_room.user_guest_id
json.messages       chat_room.messages, partial: 'info', as: :message
