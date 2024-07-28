-- messages table
CREATE TABLE message (
    id SERIAL PRIMARY KEY,
    content TEXT,
    sending_user VARCHAR(30), -- telegram user id
    conversation_id VARCHAR(30) -- some sort of unique identifier for the conversation
);

-- store individual conversations
CREATE TABLE conversation (
    id SERIAL PRIMARY KEY,
    discord_id VARCHAR(20), -- discord channel id for conversation
    telegram_id VARCHAR(20), -- telegram dm / channel id?
    webhook_url VARCHAR(100) -- url for discord webhook (to post)
);

-- main queue table that the queue service processes messages from 
CREATE TABLE queue (
    id SERIAL PRIMARY KEY,
    retry_count INT NOT NULL,
    message_id INT NOT NULL,
    created_time TIMESTAMP NOT NULL,
    FOREIGN KEY (message_id) REFERENCES message(id)
);