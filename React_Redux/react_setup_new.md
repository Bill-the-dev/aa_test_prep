## React Setup

### Initialize NPM

- `npm init -y` to setup `package.json`

### Install Dependencies

- `npm install webpack webpack-cli @babel/core @babel/preset-env @babel/preset-react babel-loader react react-dom`
    - webpack
    - webpack-cli
    - @babel/core
    - @babel/preset-env
    - @babel/preset-react
    - babel-loader
    - react
    - react-dom

### Configure Webpack ([reference](https://open.appacademy.io/learn/ch---nov-2021-ny-cohort/react/webpack))

- Create `webpack.config.js` and assign `module.exports` to the Webpack configuration object. Make sure to do the following:
    - Set your entry and output files.
        - For Rails projects, make sure to locate your `bundle.js` file in `app/assets/javascripts` so that it's included in the Rails asset pipeline.
        
        ```jsx
        // webpack.config.js
        var path = require('path');
        
        module.exports = {
          entry: "./frontend/my_app.jsx",
          output: {
              path: path.resolve(__dirname, 'app', 'assets', 'javascripts'),
              filename: "bundle.js"
          }
          // ...
        };
        ```
        
    - Configure Babel transpilation of React and ES6 syntax
        - **Configure the `module` key of your `webpack.config.js`:**
        
        ```jsx
        module: {
          rules: [
            {
              test: [/\.jsx?$/], // Specifies file types to transpile
              exclude: /(node_modules)/, // Leaves dependencies alone
              loader: 'babel-loader', // Sets Babel as the transpiler
              options: {
                presets: ['@babel/env', '@babel/react'] // Tells Babel what syntaxes to translate
              }
            }
          ]
        },
        ```
        
    - Add a `devtool`
        - `webpack.config.js` accepts a `devtool` key that can be used to enable useful tools, particularly `source-map`. A source map makes it possible for you to see the line numbers of your original source code when errors are raised. This is generally not possible because your `bundle.js` does not maintain the line numbers from the files it is bundling.
        
        ```jsx
        // webpack.config.js
        
        module.exports = {
          // ...
          devtool: 'source-map',
          // ...
        }
        ```
        
    - Ensure that `.js` and `.jsx` files resolve automatically
        - `webpack.config.js` also accepts a `resolve` key, which lets you specify what file extensions to process without explicitly naming them.
        - Must include the star matcher `'*'` to be able to include files with an explicit extension. Otherwise `require('file_name.js')` will cause webpack to look for `file_name.js.js`.
        
        ```jsx
        // webpack.config.js
        
        module.exports = {
          // ...
          resolve: {
            extensions: ['.js', '.jsx', '*']
          },
          // ...
        };
        ```
        

### Configure `package.json`

*(created above)*

- Add a `webpack` script for webpack to your `package.json`
    - `"webpack": "webpack --mode=development --watch"`
    
    ```jsx
    // ... 
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1",
        "webpack": "webpack --mode=development --watch"
      },
    // ...
    ```
    
- Create a `.gitignore` for your node modules and bundled files
    - To re-fetch the NPM modules, run `npm install`, which fetches all the modules specified in `package.json`. Then run `webpack` to regenerate the `bundle.js` and `bundle.js.map` files.
    - Collection of [useful .gitignore templates](https://github.com/github/gitignore).
    
    ```jsx
    node_modules/
    bundle.js
    bundle.js.map
    ```
    

### Boot It Up

- Run `npm run webpack` in your terminal, then open `index.html`.

