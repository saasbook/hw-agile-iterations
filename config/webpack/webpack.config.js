const path = require('path');
const webpack = require('webpack');

const mode = process.env.NODE_ENV === 'development' ? 'development' : 'production';
const sourceMaps = mode === 'development' ? 'eval-source-map' : 'source-map';

module.exports = {
  mode,
  devtool: sourceMaps,
  entry: {
    application: './app/javascript/application.js',
    national_states_map: './app/javascript/national_states_map.js',
    state_map: './app/javascript/state_map.js',
    county_map: './app/javascript/county_map.js',
    events_new: './app/javascript/events_new.js',
    events_index: './app/javascript/events_index.js'
  },
  optimization: {
    moduleIds: 'deterministic',
  },
  module: {
    rules: [
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ['babel-loader'],
      },
      {
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: {
            exposes: [
              {
                globalName: '$',
                override: true,
              },
              {
                globalName: 'jQuery',
                override: true,
              },
            ],
          },
        }],
      },
    ],
  },
  output: {
    filename: '[name].js',
    chunkFilename: '[name]-[contenthash].digested.js',
    sourceMapFilename: '[file]-[fullhash].map',
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds'),
    hashFunction: 'sha256',
    hashDigestLength: 64,
  },
  // output: {
  //   filename: '[name].js',
  //   sourceMapFilename: '[file].map',
  //   chunkFormat: 'module',
  //   path: path.resolve(__dirname, '..', '..', 'app/assets/builds'),
  // },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
    }),
  //   new webpack.optimize.LimitChunkCountPlugin({
  //     maxChunks: 1
  //   })
  ],
};
