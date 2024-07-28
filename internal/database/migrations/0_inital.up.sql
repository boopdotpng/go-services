-- where did this originate from?
create type source_type as enum('discord', 'telegram');
-- type of incident for logs - wip
create type incident_type as enum ('message_fail', 'image_pipeline_fail', 'other')

-- an individual message
create table messages (
    id serial primary key,
    message_id varchar(20) not null, -- discord or telegram id
    source source_type not null,
    user int not null references users(id), 
    content text not null,
    img_url text,  -- optional url to an image
    conversation_id int not null references conversations(id),
    message_sent_time timestamp(3) with time zone 'UTC', 
);

-- links discord and telegram users together
create table users (
    id serial primary key,
    user_id varchar(20) not null, -- telegram user id, most likely. only one person on discord team responding but we will save either way
    platform source_type not null,
    profile_image text not null, -- url to profile image
);

-- store conversations (a thread of messages)
CREATE TABLE conversations (
    id SERIAL PRIMARY KEY,
    discord_channel_id VARCHAR(20), -- discord channel id for conversation
    telegram_channel_id VARCHAR(20), -- telegram dm / channel id?
    webhook_url VARCHAR(100) -- url for discord webhook (to post replies)
);

-- main queue table that the queue service processes messages from 
CREATE TABLE queue (
    id SERIAL PRIMARY KEY,
    retry_count INT NOT NULL, -- max 3 retries, log failure
    enter_time TIMESTAMP(3) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    message_id int not null references message(id)
);

-- work in progress - will elaborate on later
create table logs (
    id serial primary key,
    incident_type enum not null,
    error text not null,
    source text not null,
    detailObject text not null
);