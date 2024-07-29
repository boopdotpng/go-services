## api service endpoints

All api endpoints are hosted on localhost:3000 by default.

### post: /create/message

```json
data: {
    message_id: 12444,
    source: "discord", // discord or telegram
    user_id: "",
    content: "",
    img_url: "",
    conversation_id: 2134,
    current_time: "2024-07-28T22:32:02Z",
}
```

### post: /create/conversation

```json
data: {
    webhook_url: "",
    telegram_conversation_id: "",
    discord_conversation_id: "",
}
```

### post: /create/user

```json
data: {
    user_id: null,
    platform: "", // discord or telegram
    profile_image: "", // url to profile
}
```

### get: /search/user

Mostly used to check if a user exists

```json
data: {
    userId: 1234,
}
```

### get /search/conversations

```json
data: {
    id: 69,
    discord_conversation_id: 1234,
    telegram_conversation_id: 1234,
    webhook_url: "",
}
```