json.id                   chat_room.id
json.user_owner_id        chat_room.user_owner_id
json.user_guest_id        chat_room.user_guest_id
if chat_room.owner?(current_user)
  json.unread_messages    chat_room.unread_messages_owner
  json.target_id          chat_room.target_owner_id
  json.title              chat_room.target_owner.title
elsif chat_room.guest?(current_user)
  json.unread_messages    chat_room.unread_messages_guest
  json.target_id          chat_room.target_guest_id
  json.title              chat_room.target_guest.title
end
json.messages chat_room.messages, partial: 'api/v1/messages/info', as: :message
