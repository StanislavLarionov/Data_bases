--usual user
CREATE USER user1 WITH PASSWORD 'password123';

GRANT CONNECT ON DATABASE crm_system TO user1;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user1; 

--moderator
CREATE USER user2 WITH PASSWORD 'password1234';
GRANT CONNECT ON DATABASE crm_system TO user2;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO user2;

--administrator (full access)
CREATE USER admin_user WITH PASSWORD 'adminpass123';
GRANT ALL PRIVILEGES ON DATABASE crm_system TO admin_user;