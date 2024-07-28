# telegram-discord sync

This set of services helps to sync telegram and discord support channels. Replies on discord will be sent to telegram and

## requirements

1. postgresql (uses default postgres db)
2. go >= 1.22.5
3. golang-migrate

## overview

- A queue service
- A websocket service
- An API service (see [api docs](https://github.com/boopdotpng/telegram-discord-sync/tree/main/docs/api.md))
- An image upload service
