module.exports = class Ui
  constructor: (@app) ->
    @levelSwitch      = $('.header--rating li')
    @reloadBtn        = $('.btn--reload-type')

    @typeGeneraterBtn = $('#type-generator')
    @randomStringTabs = $('#idioms-random, #special-random')
    @drop             = $('.drop--type-selection-footer')
    @closeDropBtn     = @drop.find('.btn--close')

    @titles       = $('.title')
    @side         = $('.sidebar--description')
    @closeSideBtn = @side.find('.btn--close')

    @bindEvents()

  bindEvents: ->
    @levelSwitch.on 'click', (e) => @app.switchLevel $(e.currentTarget).index()
    @reloadBtn.on 'click', @app.regenerateRecipe
    @typeGeneraterBtn.on 'click', => @typeGeneraterBtn.next().toggleClass('open')

    @randomStringTabs.on 'click', @getRandomString

    @closeSideBtn.on 'click', @closeSide
    @closeDropBtn.on 'click', @closeDrop

    $body.on 'click', @closeAll

    @titles.on 'click', @showSide

  closeSide: => @side.removeClass('show')
  closeDrop: => @drop.removeClass('open')

  closeAll: (e) =>
    $el = $(e.target)
    @closeSide() if !$el.closest('.sidebar--description, .type-selection__body .title').length
    @closeDrop() if !$el.closest('.type-selection__footer__list button, .drop--type-selection-footer').length

  getRandomString: (e) =>
    $tab = $(e.currentTarget)
    @app.generateRandomString($tab.data('type'))
    @randomStringTabs.removeClass('active')
    $tab.addClass('active')

  showSide: (e) =>
    @closeSide()
    $(e.currentTarget).siblings('.sidebar--description').addClass('show')
