recipes      = require('../config').recipes
assign       = require 'lodash/object/assign'
partialRight = require 'lodash/function/partialRight'
sample       = require 'lodash/collection/sample'

defaults = partialRight(assign, (current, existed) ->
  current && existed.concat(current) || existed
)

for recipe, i in recipes
  continue if i == 0
  prevOptions = recipes[i-1].options
  currentOptions = recipe.options
  recipe.options = defaults(currentOptions, prevOptions)

currentLevel = recipes[0]

updateLabel = (text) ->
  $('.current-level').text(text)

$headerRating = $('.header--rating')

$headerRating.find('.level-beginner').on 'click', ->
  currentLevel = recipes[0]
  $('.type-selection__body li').removeClass('show')
  $('.type-selection__body .level-beginner').addClass('show')
  updateLabel '入門級'

$headerRating.find('.level-normal').on 'click', ->
  currentLevel = recipes[1]
  $('.type-selection__body li').removeClass('show')
  $('.type-selection__body .level-beginner, .type-selection__body .level-normal').addClass('show')
  updateLabel '一般級'

$headerRating.find('.level-class').on 'click', ->
  currentLevel = recipes[2]
  $('.type-selection__body li').addClass('show')
  $('.type-selection__body .level-player').removeClass('show')
  updateLabel '進階級'

$headerRating.find('.level-player').on 'click', ->
  currentLevel = recipes[3]
  $('.type-selection__body li').addClass('show');
  updateLabel '玩家級'

$headerRating.find('.level-expert').on 'click', ->
  currentLevel = recipes[4]
  $('.type-selection__body li').addClass('show');
  updateLabel '專家級'

module.exports = ->
  { width, weight, construction, strokeEnding, stem, letterRange, central, gravity, contrast, application, intendedSize, special } = currentLevel.options
  $('[data-type="word-width"] .content h3').text(sample(width))
  $('[data-type="word-weight"] .content h3').text(sample(weight))
  $('[data-type="word-construction"] .content h3').text(sample(construction))
  $('[data-type="word-stroke-ending"] .content h3').text(sample(strokeEnding))
  $('[data-type="word-stem"] .content h3').text(sample(stem))
  $('[data-type="word-letter-range"] .content h3').text(sample(letterRange))
  $('[data-type="word-central"] .content h3').text(sample(central))
  $('[data-type="word-gravity"] .content h3').text(sample(gravity))
  $('[data-type="word-contrast"] .content h3').text(sample(contrast))
  $('[data-type="word-application"] .content h3').text(sample(application))
  $('[data-type="word-intended-size"] .content h3').text(sample(intendedSize))
  $('[data-type="word-special"] .content h3').text(sample(special))
