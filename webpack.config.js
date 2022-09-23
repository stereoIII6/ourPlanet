const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const { LoaderOptionsPlugin } = require("webpack");

module.exports = {
  mode: "development",
  entry: {
    main: path.resolve(__dirname, "src/app.js"),
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "[name].[contenthash].js",
    clean: false,
  },
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: ["style-loader", "css-loader", "sass-loader"],
      },
      { test: /\.(svg|png|ico|wepg|jpg|jpeg|gif)$/, use: ["asset/resource"] },
    ],
  },
  devtool: "inline-source-map",
  devServer: {
    watchFiles: path.resolve(__dirname, "dist"),
    compress: true,
    port: 5050,
    open: true,
    hot: true,
    liveReload: true,
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "ecoverse",
      file: "index.html",
      template: "public/app.html",
    }),
    new CopyWebpackPlugin({
      patterns: [
        { from: "public/images", to: "images" },
        { from: "public/cols", to: "cols" },
        { from: "public/fonts", to: "fonts" },
        { from: "public/layouts", to: "layouts" },
        { from: "public/words", to: "words" },
      ],
    }),
  ],
};
