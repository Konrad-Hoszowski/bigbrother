//const debug = process.env.NODE_ENV !== "production";
const Webpack = require('webpack');
const Path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  context: Path.join(__dirname, "src"),
  // devtool: debug ? "inline-sourcemap" : false,
  entry: "./client/client.js",
  module: {
    rules: [
      {
        test: /\.js?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel-loader',
        query: {
          presets: ['react', 'env', 'stage-0']
          // plugins: ['react-html-attrs', 'transform-decorators-legacy', 'transform-class-properties'],
        }
      }
    ]
  },
  output: {
    path: __dirname + "/dist/",
    filename: "client/client.min.js"
  },
  plugins: [
        new CopyWebpackPlugin([
          { from: './main.js', to: '.' },
          { from: './client/*.html', to: '.' }
        ])
    ]
  // plugins: debug ? [] : [
    // new webpack.optimize.DedupePlugin(),
    // new webpack.optimize.OccurrenceOrderPlugin(),
    // new webpack.optimize.UglifyJsPlugin({ mangle: false, sourcemap: false }),
  // ],
};
