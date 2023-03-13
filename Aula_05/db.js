const sql = require("mssql");

const config = {
    user: 'sa',
    password: '123456',
    server: 'localhost',
    port: 1434,
    database: 'CRUDSCRIPT',
    options: { encrypt: false }
}

async function connect() 
{
    try {
        await sql.connect(config)
        console.log("Conexão com o banco estabelecida!");
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    connect,
    sql
}