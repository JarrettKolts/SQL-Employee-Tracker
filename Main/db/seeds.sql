\c company_db;
INSERT INTO department (department_name)
VALUES ('Sales'),
       ('Customer Service'),
       ('Training'),
       ('Human Resources'),
       ('Marketing'),
       ('Legal');

INSERT INTO role (department_id, role_title, role_salary)
VALUES 
    (1, 'Sales Manager', 75000),
    (1, 'Sales Associate', 50000),
    (2, 'Customer Service Representative', 40000),
    (2, 'Customer Service Manager', 65000),
    (3, 'Training Specialist', 60000),
    (3, 'Training Coordinator', 55000),
    (4, 'HR Manager', 70000),
    (4, 'HR Assistant', 45000),
    (5, 'Marketing Director', 80000),
    (5, 'Marketing Coordinator', 50000),
    (6, 'Legal Counsel', 90000),
    (6, 'Legal Assistant', 55000);

INSERT INTO employee (first_name, last_name, role_id, manager_id)
VALUES 
    ('Alice', 'Johnson', 1, NULL), -- Sales Manager, no manager
    ('Bob', 'Smith', 2, 1), -- Sales Associate, reports to Sales Manager (Alice)
    ('Carol', 'Williams', 3, 4), -- Customer Service Rep, reports to CS Manager (Dave)
    ('Dave', 'Brown', 4, NULL), -- Customer Service Manager, no manager
    ('Eve', 'Jones', 5, NULL), -- Training Specialist, no manager
    ('Frank', 'Miller', 6, 5), -- Training Coordinator, reports to Training Specialist (Eve)
    ('Grace', 'Davis', 7, NULL), -- HR Manager, no manager
    ('Hank', 'Wilson', 8, 7), -- HR Assistant, reports to HR Manager (Grace)
    ('Ivy', 'Clark', 9, NULL), -- Marketing Director, no manager
    ('Jack', 'Lopez', 10, 9), -- Marketing Coordinator, reports to Marketing Director (Ivy)
    ('Karen', 'Hill', 11, NULL), -- Legal Counsel, no manager
    ('Leo', 'Scott', 12, 11); -- Legal Assistant, reports to Legal Counsel (Karen)
