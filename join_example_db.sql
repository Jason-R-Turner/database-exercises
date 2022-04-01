USE join_example_db;

SHOW TABLES;

select * from roles;

SELECT 
    u.name, u.email, r.name as 'Role Name'
FROM
    users AS u
        JOIN
    roles AS r ON u.role_id = r.id; 