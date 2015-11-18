menu = class Menu
  constructor: ->
    @languageSelect   = $('.language-select')
    @triggerAbout     = $('.trigger--about')
    @menuMain         = $('.menu__main')
    @menuAbout        = @menuMain.filter('.menu--about')
    @menuAboutContent = @menuAbout.find('.menu--about__contents')
    @menuLanguage     = @menuMain.filter('.menu--language')
    @closeBtn         = @menuMain.find('.btn--close')

    @languageSelect.on 'click', => @menuLanguage.toggleClass('open')
    @triggerAbout.on 'click', => @menuAbout.toggleClass('open')
    @closeBtn.on 'click', => @menuMain.removeClass('open')

    ['kanjicooker', 'usage', 'social'].forEach (type) =>
      @["#{type}Btn"] = $(".show-about-#{type}")
      @["#{type}Menu"] = $(".menu--about--#{type}")
      @["#{type}Btn"].on 'click', =>
        @menuAboutContent.removeClass 'active'
        @["#{type}Menu"].addClass 'active'

new menu()
