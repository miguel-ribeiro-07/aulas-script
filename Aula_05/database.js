const sql = require('mssql')

const config = {
    user: 'sa',
    password:'fatec123*',
    server:'localhost',
    port:'1433',
    database:'ProgSCRIPT',
    options:{ecrypt : false}
}

async function connect(){
    try{
        await sql.connect(config);
        console.log("O banco está conectado!")
    }catch(err){
        console.error(err)
    }
}

module.exports = {
    sql,
    connect
}