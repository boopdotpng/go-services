-- create type source_type as enum('discord', 'telegram');
CREATE TYPE source_type as ENUM ('discord', 'telegram');

-- type of incident for logs - wip
CREATE TYPE incident_type as ENUM (
    'message_fail',
    'image_pipeline_fail',
    'other'
);

-- an individual message
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    message_id BIGINT, -- Telegram message ID (optional)
    source source_type NOT NULL,
    user_id BIGINT NOT NULL REFERENCES users(id),
    content TEXT NOT NULL,
    img_url TEXT, -- optional URL to an image
    conversation_id INTEGER NOT NULL REFERENCES conversations(id),
    message_sent_time TIMESTAMP(3) WITH TIME ZONE 'UTC' NOT NULL DEFAULT CURRENT_TIMESTAMP AT TIME
ZONE 'UTC'
);

-- links Discord and Telegram users together
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_id BIGINT, -- Discord or telegram user ID (if applicable)
    platform source_type NOT NULL,
    profile_image TEXT NOT NULL -- URL to profile image
);

-- store conversations (a thread of messages)
CREATE TABLE conversations (
    id SERIAL PRIMARY KEY,
    discord_conversation_id INTEGER, -- Discord conversation ID (if applicable)
    telegram_conversation_id INTEGER, -- Telegram DM/Channel ID (if applicable)
    webhook_url TEXT NOT NULL -- URL for Discord webhook
);

-- main queue table that the queue service processes messages from
CREATE TABLE queue (
    id SERIAL PRIMARY KEY,
    retry_count INTEGER NOT NULL CHECK (retry_count <= 3), -- max 3 retries, log failure
    enter_time TIMESTAMP(3) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP AT TIME ZONE 'UTC' NOT NULL,
    message_id BIGINT NOT NULL REFERENCES messages(id)
);

-- work in progress - will elaborate on later
CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    incident_type incident_type NOT NULL,
    error TEXT NOT NULL,
    source TEXT NOT NULL,
    detail_object TEXT NOT NULL,
    occurred_at TIMESTAMP(3) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP AT TIME ZONE 'UTC' NOT NULL
);