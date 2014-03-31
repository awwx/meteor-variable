class _Variable
  equals: (a, b) ->
    EJSON.equals a, b

  constructor: (initialValue) ->
    return new _Variable initialValue if @ not instanceof _Variable

    value = initialValue
    dep = new Deps.Dependency()

    fn = ->
      dep.depend()
      return value

    fn.set = (newValue) =>
      unless @equals newValue, value
        value = newValue
        dep.changed()
      return

    return fn

if Package?
  Variable = _Variable
else
  @Variable = _Variable
