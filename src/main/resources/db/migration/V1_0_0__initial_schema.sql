CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN', 'USER'))
);

CREATE TABLE tasks (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) NOT NULL,
    author_id BIGINT,
    assignee_id BIGINT,
    priority VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comments (
    id BIGSERIAL PRIMARY KEY,
    content TEXT,
    task_id BIGINT REFERENCES tasks(id),
    user_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE tasks ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES users(id);
ALTER TABLE tasks ADD CONSTRAINT fk_assignee FOREIGN KEY (assignee_id) REFERENCES users(id);
ALTER TABLE comments ADD CONSTRAINT fk_task FOREIGN KEY (task_id) REFERENCES tasks(id);
ALTER TABLE comments ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id);


INSERT INTO users (id, email, username, password, role)
VALUES (1, 'admin@example.com', 'admin', 'admin', 'ADMIN');