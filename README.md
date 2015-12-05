# KanjiCooker
Lettering Tool for Kanji

## Install
1. make sure you've installed `node` and `bower`
2. run `npm install` and `bower install`
3. copy `.env.json.example` into `.env.json` and edit some of your configs if necessary
4. to develop, run `gulp`
5. to release, run `gulp build`

## Setup your environment with .env.json
Copy `.env.json.example` into `.env.json` with your settings

### Options
- `HOST` - you can use `domain` or `local ip` if you want to share your development with other users and/or across different devices.
- `PORT` - port you would like to use to differentiate from other projects
- `AUTOPREFIXER_BROWSERS` - default uses `last 3 version`
- `ENVIRONMENT` - if set to `dev`, the environment will run sass as development mode instead of minifying, this is useful when deploying on server with `build`.


## File Structure
```
├── README.md
├── bower.json
├── bower_components
├── build
│   ├── css
│   ├── fonts
│   ├── img
│   ├── index.html
│   └── js
├── gulpfile.js
├── node_modules
├── package.json
└── src
    ├── fonts
    ├── img
    ├── js
    ├── pages
    └── sass
```
