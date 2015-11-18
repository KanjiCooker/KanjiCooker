window.$        = require 'jquery'
window.config   = require 'main/config'
window.$body    = $('body')
window.printout = -> if !window.print then alert('列印功能暫時停用，請按 Ctrl-P 來列印') else window.print()
window.xx = (t) -> console.info(t)

require 'main/app'
require 'main/menu'

# to fix webfont dynamic loading issue
str = JSON.stringify(config.recipes).replace(/([{}":\[\],\w])/g, '').replace(/(.)(?=.*\1)/g, '')
$('<span />').text(str).appendTo($body).hide()
