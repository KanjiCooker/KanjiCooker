{ randomIdioms, randomSpecial } = require('../main/random')

$typeGenerator = $('#type-generator')
$idiomsRandom  = $('#idioms-random')
$specialRandom = $('#special-random')
$tabs = $idiomsRandom.add($specialRandom)

$typeGenerator.on 'click', ->
  $typeGenerator.next().toggleClass('open')

$idiomsRandom.on 'click', ->
  $specialRandom.removeClass('active')
  $idiomsRandom.addClass('active')
  randomIdioms()

$specialRandom.on 'click', ->
  $idiomsRandom.removeClass('active')
  $specialRandom.addClass('active')
  randomSpecial()
