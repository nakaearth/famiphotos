module.exports = {
  entry: {
    app: './src/index.js',
  },

  output: {
    path: __dirname + '/../app/assets/javascripts/webpack/',
    filename: '[name].js',
  },

  module: {
    loaders: [
      { test: /\.(js|jsx)$/,
        loader: "babel",
        exclude: /node_modules/,
        query: {
          presets: ["es2016", "react"],
        }
      },
    ]
  },
}
