json.chat_rooms @chat_rooms do |chat_room|
  json.id                   chat_room.id

  if chat_room.owner?(current_user)
    json.unread_messages    chat_room.unread_messages_owner
    json.target             chat_room.target_owner, partial: 'info', as: :target
  elsif chat_room.guest?(current_user)
    json.unread_messages    chat_room.unread_messages_guest
    json.target             chat_room.target_guest, partial: 'info', as: :target
  end
end
