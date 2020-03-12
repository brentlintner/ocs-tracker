const { environment } = require('@rails/webpacker')

// Webpack 3 behaviour (we only using frontend)
environment.loaders.delete('nodeModules')

module.exports = environment
