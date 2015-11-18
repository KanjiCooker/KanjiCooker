sample    = require 'lodash/collection/sample'
mapValues = require 'lodash/object/mapValues'
Ui        = require './ui'
Updater   = require './updater'

initLevel = 0

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
    switch type
      when 'ipsum'
        @ipsum  = sample(config.ipsums)
        @updater.updateIpsum()
      when 'idiom'
        @idiom  = sample(config.idioms)
        @updater.updateIdiom()

  switchLevel: (@currentLevelIndex) ->
    @currentLevel = @levels[@currentLevelIndex]
    @regenerateRecipe()

window.app = new App()
