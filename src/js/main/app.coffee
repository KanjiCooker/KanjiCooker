palette   = require 'plugins/palette'
mapValues = require 'lodash/object/mapValues'
Ui        = require './ui'
Updater   = require './updater'

initLevel = 0

sample = (array) -> array[Math.floor(Math.random() * array.length)]

class App
  constructor: ->
    @levels = config.recipes
    @ui = new Ui(@)
    @updater = new Updater(@)
    @switchLevel(initLevel)

  regenerateRecipe: =>
    @recipe = mapValues(@currentLevel.options, (options) -> sample(options))
    @color  = palette.get(sample(config.colors), '500')
    @updater.updateRecipe()

  generateRandomString: (type) ->
    @[type] = sample(config["#{type}s"])
    @updater.updateString(type)

  switchLevel: (@currentLevelIndex) ->
    @currentLevel = @levels[@currentLevelIndex]
    @regenerateRecipe()

window.app = new App()
