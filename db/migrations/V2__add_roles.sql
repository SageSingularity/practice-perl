-- Add roles functionality
-- Version: 2.0
-- Description: Adds roles and user_roles tables

-- Roles table
CREATE TABLE roles (
    role_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_name VARCHAR2(50) NOT NULL UNIQUE,
    description VARCHAR2(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User roles junction table
CREATE TABLE user_roles (
    user_id NUMBER NOT NULL,
    role_id NUMBER NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_user_roles PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Add comments
COMMENT ON TABLE roles IS 'Stores available roles in the system';
COMMENT ON TABLE user_roles IS 'Junction table linking users to their roles'; 