## api service endpoints

All api endpoints are hosted on localhost:3000 by default.

### post: /create/message

```json
{
  "data": {
    "message_id": 12444,
    "source": "discord",
    "user_id": "728390217654321",
    "content": "Hello, how's everyone doing today?",
    "img_url": "https://example.com/images/profile_pic.jpg",
    "conversation_id": 2134,
    "current_time": "2024-07-28T22:32:02Z"
  }
}
```

### post: /create/conversation

```json
{
  "data": {
    "webhook_url": "https://discord.com/api/webhooks/123456789/abcdefghijklmnopqrstuvwxyz",
    "telegram_conversation_id": "-100123456789",
    "discord_conversation_id": "987654321098765432"
  }
}
```

### post: /create/user

```json
{
  "data": {
    "user_id": "987654321",
    "platform": "telegram",
    "profile_image": "https://t.me/i/userpic/320/username.jpg"
  }
}
```

### get: /search/user

Mostly used to check if a user exists

```json
{
  "data": {
    "userId": "728390217654321"
  }
}
```

### get /search/conversations

```json
{
  "data": {
    "id": 69,
    "discord_conversation_id": "987654321098765432",
    "telegram_conversation_id": "-100123456789",
    "webhook_url": "https://discord.com/api/webhooks/123456789/abcdefghijklmnopqrstuvwxyz"
  }
}
```
