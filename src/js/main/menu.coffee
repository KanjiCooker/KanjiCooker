menu = class Menu
  constructor: ->
    @currentPageIndex = 0
    @languageSelect   = $('.language-select')
    @triggerAbout     = $('.trigger--about')
    @menuMain         = $('.menu__main')
    @menuAbout        = @menuMain.filter('.menu--about')
    @menuAboutContent = @menuAbout.find('.menu--about__contents')
    @menuAboutArrows  = @menuAbout.find('[data-type]')
    @menuLanguage     = @menuMain.filter('.menu--language')
    @closeBtn         = @menuMain.find('.btn--close')

    @languageSelect.on 'click', => @menuLanguage.toggleClass('open')
    @triggerAbout.on 'click', => @menuAbout.toggleClass('open')
    @closeBtn.on 'click', => @menuMain.removeClass('open')
    @menuAboutArrows.on 'click', @clickHandler

  clickHandler: (e) =>
    @currentPageIndex += if e.currentTarget.getAttribute('data-type') == 'next' then 1 else -1
    @menuAboutContent.removeClass('active').eq(@currentPageIndex).addClass('active')

new menu()
