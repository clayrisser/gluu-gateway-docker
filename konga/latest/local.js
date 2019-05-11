const fs = require('fs');
const path = require('path');

const { env } = process;

module.exports = {
  clientId: env.CLIENT_ID || '',
  clientSecret: env.CLIENT_SECRET || 'some-secret',
  environment: env.NODE_ENV || 'development',
  explicitHost: env.EXPLICIT_HOST || 'localhost',
  ggVersion: env.GG_VERSION || '1.0',
  hookTimeout: 180000,
  kong_admin_url: process.env.KONG_ADMIN_URL || 'http://localhost:8001',
  opHost: env.OP_HOST || 'http://localhost:8080',
  oxdId: env.OXD_ID || '',
  oxdVersion: env.OXD_VERSION || '4.0',
  oxdWeb: env.OXD_WEB || 'http://localhost:8443',
  port: Number(process.env.PORT) || 1338,
  connections: {
    postgres: {
      adapter: 'sails-postgresql',
      database: env.DB_DATABASE || 'konga',
      host: env.DB_HOST || 'localhost',
      password: env.DB_PASSWORD || 'postgres',
      poolSize: env.DB_POOLSIZE ? Number(env.DB_POOLSIZE) : 10,
      port: env.DB_PORT ? Number(env.DB_PORT) : 5432,
      ssl: (env.DB_SSL || '').toLowerCase() === 'true',
      user: env.DB_USER || 'postgres'
    }
  },
  log: {
    level: 'info'
  },
  models: {
    connection: 'postgres'
  },
  session: {
    secret: env.SECRET || ''
  },
  ssl: {
    key: fs.readFileSync(path.resolve(__dirname, 'tls.key')),
    cert: fs.readFileSync(path.resolve(__dirname, 'tls.crt'))
  }
};
