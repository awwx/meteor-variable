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


keyTest = (test, obj) ->
  test.equal obj(), {}

  obj.set
    a: 123
    b: 234
  test.equal obj(),
    a: 123
    b: 234

  updates = 0
  current = null
  Deps.autorun (computation) ->
    ++updates
    current = obj()
    return

  test.equal updates, 1
  test.equal current,
    a: 123
    b: 234
  test.equal obj(),
    a: 123
    b: 234

  obj.set
    a: 567
    b: 123
  Deps.flush()
  test.equal updates, 1
  test.equal current,
    a: 123
    b: 234
  test.equal obj(),
    a: 123
    b: 234

  obj.set
    a: 123
  Deps.flush()
  test.equal updates, 2
  test.equal current,
    a: 123
  test.equal obj(),
    a: 123


class SpecialVariable extends Variable
  equals: (a, b) ->
    a = _.keys a
    b = _.keys b
    a.length is b.length and _.difference(a, b).length is 0


Tinytest.add 'variable - get and set', (test) ->
  weatherTest test, Variable('sunny')


Tinytest.add 'variable - new Variable also works', (test) ->
  weatherTest test, new Variable('sunny')


Tinytest.add 'variable - extended variable', (test) ->
  keyTest test, new SpecialVariable({})
