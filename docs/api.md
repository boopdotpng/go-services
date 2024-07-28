## api service endpoints

All api endpoints are hosted on localhost:3000 by default. You can change this by passing --api-port as a command line option.

### get_count

Returns the number of messages currently in the queue

### add

Adds a message to the queue

### consume

Consumes a message from the queue

### inc_retry

Increments the retry count of the queue object (max. 3)

### add_failure

Logs message failure and adds queue to failed list