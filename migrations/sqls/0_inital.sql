-- main queue table that the queue service processes messages from 
create table queue (
    id serial primary key,
    retry_count int not null,
    messageId foreign key message.id not null,
    createdTime varchar(20) not null,
)

-- messages table
create table message (
    id serial primary key,
    content text,
    sendingUser varchar(18) -- telegram user id
)

-- conversations table 
create table conversations (

)

-- webhooks table
create table webhooks (

)