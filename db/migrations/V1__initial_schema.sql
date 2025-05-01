-- Initial schema creation
-- Version: 1.0
-- Description: Creates initial database tables

-- Users table
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email
CREATE INDEX idx_users_email ON users(email);

-- Add comments
COMMENT ON TABLE users IS 'Stores user information';
COMMENT ON COLUMN users.user_id IS 'Primary key for users table';
COMMENT ON COLUMN users.username IS 'Unique username for the user';
COMMENT ON COLUMN users.email IS 'Unique email address for the user'; 