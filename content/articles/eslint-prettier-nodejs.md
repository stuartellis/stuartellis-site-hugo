+++
Title = "Using ESLint and Prettier with Node.js"
Slug = "eslint-prettier-nodejs"
Date = "2018-04-17T17:36:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["node.js"]
Type = "article"
Draft = true

+++

This article shows how to set up ESLint and Prettier to format and check your JavaScript code.

<!--more-->

First, install the packages into your project:

    npm install -D eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint

Next, add an *npm script* to provide a convenient way to run ESLint:

~~~json
  "scripts": {
    "pretest": "eslint --ignore-path .gitignore ."
  }
~~~

The default settings of Prettier do not support the new features of ES2017 that are included with Node.js 8 and above. To use Prettier with ES2017, create a configuration file for ESLint in your project called *.eslintrc.json* with these settings:

~~~json
{
  "extends": [
    "plugin:prettier/recommended",
    "eslint:recommended"
  ],
  "parserOptions": {
    "ecmaVersion": 2017
  },
  "env": {
    "node": true
  }
}
~~~

You can now use run one command to format and check your code:

    npm run pretest

# Visual Studio Code #

To integrate ESLint and Prettier with Visual Studio Code, install the *prettier-vscode* extension by Esben Petersen:

    ext install dbaeumer.vscode-eslint prettier-vscode

Finally, enable *editor.formatOnSave* for JavaScript files:

~~~json
{
  "[javascript]": {
    "editor.formatOnSave": true
  }
}
~~~

This will re-format your code each time that you save a Javascript file.
