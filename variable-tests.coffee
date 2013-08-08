weatherTest = (test, weather) ->
  test.equal weather(), 'sunny'

  weather.set('raining')
  test.equal weather(), 'raining'

  updates = 0
  current = null
  Deps.autorun (computation) ->
    ++updates
    current = weather()
    return

  test.equal updates, 1
  test.equal current, 'raining'

  weather.set('raining')
  Deps.flush()
  test.equal updates, 1
  test.equal current, 'raining'

  weather.set('cloudy')
  Deps.flush()
  test.equal updates, 2
  test.equal current, 'cloudy'


Tinytest.add 'variable - get and set', (test) ->
  weatherTest test, Variable('sunny')


Tinytest.add 'variable - new Variable also works', (test) ->
  weatherTest test, new Variable('sunny')
