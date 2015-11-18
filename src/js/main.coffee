if window.navigator.userAgent.match(/MSIE\s8\.0/) != null
  urls = ['/ie8/01.html', '/ie8/02.html']
  window.location.href = urls[Math.floor(urls.length*Math.random())]

window.$         = require 'jquery'
window.$body     = $('body')
window.classList = require 'plugins/classList'
window.palette   = require 'plugins/palette'
window.printout  = -> if !window.print then alert('列印功能暫時停用，請按 Ctrl-P 來列印') else window.print()
window.xx = (t) -> console.info(t)

require 'main/menu'
require 'main/sidebar'
require 'main/index'
require 'partial/type-generator'
