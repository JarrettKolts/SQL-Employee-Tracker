const inquirer = require('inquirer');
const db = require('./db');

async function mainMenu() {
    const { action } = await inquirer.prompt([
        {
            type: 'list',
            name: 'action',
            message: 'Choose an action:',
            choices: [
                'View All Departments',
                'View All Roles',
                'View All Employees',
                'Add Department',
                'Add Role',
                'Add Employee',
                'Update Employee Role',
                'Exit'
            ]
        }
    ]);

    switch (action) {
        case 'View All Departments':
            viewAllDepartments();
            break;
        case 'View All Roles':
            viewAllRoles();
            break;
        case 'View All Employees':
            viewAllEmployees();
            break;
        case 'Add Department':
            addDepartment();
            break;
        case 'Add Role':
            addRole();
            break;
        case 'Add Employee':
            addEmployee();
            break;
        case 'Update Employee Role':
            updateEmployeeRole();
            break;
        default:
            console.log('Goodbye!');
            process.exit();
    }
}

async function viewAllDepartments() {
    const res = await db.query('SELECT * FROM department');
    console.table(res.rows);
    mainMenu();
}

async function viewAllRoles() {
    const res = await db.query(`
        SELECT role.id, role.title, department.name AS department, role.salary 
        FROM role 
        JOIN department ON role.department_id = department.id
    `);
    console.table(res.rows);
    mainMenu();
}

async function viewAllEmployees() {
    const res = await db.query(`
        SELECT employee.id, employee.first_name, employee.last_name, role.title, 
               department.name AS department, role.salary, 
               COALESCE(manager.first_name || ' ' || manager.last_name, 'None') AS manager
        FROM employee 
        LEFT JOIN role ON employee.role_id = role.id 
        LEFT JOIN department ON role.department_id = department.id 
        LEFT JOIN employee manager ON employee.manager_id = manager.id
    `);
    console.table(res.rows);
    mainMenu();
}

// Additional functions for adding and updating records
async function addDepartment() {
    const { name } = await inquirer.prompt([
        { type: 'input', name: 'name', message: 'Department name:' }
    ]);
    await db.query('INSERT INTO department (department_name) VALUES ($1)', [name]);
    console.log(`Added department: ${name}`);
    mainMenu();
}

async function addRole() {
    const departments = await db.query('SELECT * FROM department');
    const { title, salary, departmentId } = await inquirer.prompt([
        { type: 'input', name: 'title', message: 'Role title:' },
        { type: 'input', name: 'salary', message: 'Role salary:' },
        { type: 'list', name: 'departmentId', message: 'Department:', choices: departments.rows.map(d => ({ name: d.name, value: d.id })) }
    ]);
    await db.query('INSERT INTO role (role_title, role_salary, department_id) VALUES ($1, $2, $3)', [title, salary, departmentId]);
    console.log(`Added role: ${title}`);
    mainMenu();
}

async function addEmployee() {
    const roles = await db.query('SELECT * FROM role');
    const employees = await db.query('SELECT * FROM employee');
    const { firstName, lastName, roleId, managerId } = await inquirer.prompt([
        { type: 'input', name: 'firstName', message: 'First name:' },
        { type: 'input', name: 'lastName', message: 'Last name:' },
        { type: 'list', name: 'roleId', message: 'Role:', choices: roles.rows.map(r => ({ name: r.title, value: r.id })) },
        { type: 'list', name: 'managerId', message: 'Manager:', choices: [{ name: 'None', value: null }, ...employees.rows.map(e => ({ name: `${e.first_name} ${e.last_name}`, value: e.id }))] }
    ]);
    await db.query('INSERT INTO employee (first_name, last_name, role_id, manager_id) VALUES ($1, $2, $3, $4)', [firstName, lastName, roleId, managerId]);
    console.log(`Added employee: ${firstName} ${lastName}`);
    mainMenu();
}

async function updateEmployeeRole() {
    const employees = await db.query('SELECT * FROM employee');
    const roles = await db.query('SELECT * FROM role');
    const { employeeId, roleId } = await inquirer.prompt([
        { type: 'list', name: 'employeeId', message: 'Choose employee to update:', choices: employees.rows.map(e => ({ name: `${e.first_name} ${e.last_name}`, value: e.id })) },
        { type: 'list', name: 'roleId', message: 'New role:', choices: roles.rows.map(r => ({ name: r.title, value: r.id })) }
    ]);
    await db.query('UPDATE employee SET role_id = $1 WHERE id = $2', [roleId, employeeId]);
    console.log(`Updated employee's role.`);
    mainMenu();
}

mainMenu(); // Starts the application
