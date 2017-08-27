const { Client } = require('pg');

const client = new Client({
  user: 'StevenD',
  host: 'localhost',
  database: 'machinedb',
  password: '',
  port: 5432,
});

client.connect();

module.exports = {
  query: (text, params, callback) => {
    return client.query(text, params, callback)
  }
}
