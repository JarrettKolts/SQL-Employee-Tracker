-- * `department`

--   * `id`: `SERIAL PRIMARY KEY`

--   * `name`: `VARCHAR(30) UNIQUE NOT NULL` to hold department name
DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;

\c company_db;

CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

-- * `role`

--   * `id`: `SERIAL PRIMARY KEY`

--   * `title`: `VARCHAR(30) UNIQUE NOT NULL` to hold role title

--   * `salary`: `DECIMAL NOT NULL` to hold role salary

--   * `department_id`: `INTEGER NOT NULL` to hold reference to department role belongs to
CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    department_id INT,
    role_title VARCHAR(50) UNIQUE NOT NULL,
    role_salary DECIMAL NOT NULL,
    FOREIGN KEY (department_id)
    REFERENCES department(id)
    ON DELETE SET NULL
);

-- * `employee`

--   * `id`: `SERIAL PRIMARY KEY`

--   * `first_name`: `VARCHAR(30) NOT NULL` to hold employee first name

--   * `last_name`: `VARCHAR(30) NOT NULL` to hold employee last name

--   * `role_id`: `INTEGER NOT NULL` to hold reference to employee role

--   * `manager_id`: `INTEGER` to hold reference to another employee that is the manager of the current employee (`null` if the employee has no manager)

CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role_id INTEGER NOT NULL,
    manager_id INTEGER,
    FOREIGN KEY (role_id)
        REFERENCES role(id)
        ON DELETE SET NULL,
    FOREIGN KEY (manager_id)
        REFERENCES employee(employee_id)
        ON DELETE SET NULL
);
-- CREATE DATABASE company_db;

-- CREATE TABLE department ( 
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(30) UNIQUE NOT NULL
-- );

-- CREATE TABLE role (
--     id SERIAL PRIMARY KEY,
--     title VARCHAR(30) UNIQUE NOT NULL,
--     salary DECIMAL NOT NULL,
--     department_id INTEGER REFERENCES department(id)
-- );

-- CREATE TABLE employee (
--     id SERIAL PRIMARY KEY,
--     first_name VARCHAR(30) NOT NULL,
--     last_name VARCHAR(30) NOT NULL,
--     role_id INTEGER REFERENCES role(id),
--     manager_id INTEGER REFERENCES employee(id)
-- );
