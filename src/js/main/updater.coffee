kebabCase = require 'lodash/string/kebabCase'

module.exports = class Updater
  constructor: (@app) ->
    { @levelLabels } = config
    @levelSwitch     = $('.header--rating li')
    @currentLevelEl  = $('.current-level')
    @randomColorEl   = $('.random--color').add(@levelSwitch)
    @randomBgColorEl = $('.random--background')
    @randomStringEl  = $('.drop--type-selection-footer .content h3')

    @recipesWrapper = $('.type-selection__body')

  updateRecipe: ->
    @levelSwitch.removeClass('active').eq(@app.currentLevelIndex).addClass('active')

    @recipesWrapper.attr('data-level', @app.currentLevel.label)

    @randomColorEl.css
      color: @app.color
      borderBottomColor: @app.color

    @randomBgColorEl.css
      backgroundColor: @app.color

    @currentLevelEl.text @levelLabels[@app.currentLevelIndex]

    for attribute, value of @app.recipe
      kebab = kebabCase(attribute)
      $("[data-type='word-#{kebab}'] .content h3").text(@app.recipe[attribute] + '。')

  updateIdiom: -> @randomStringEl.text @app.idiom
  updateIpsum: -> @randomStringEl.text @app.ipsum
