isPlainObject = require "is-plain-object"
isString = require "is-string"
isNumber = require "is-number"

module.exports = dd = {}

dd.get = (object, path) ->
  todoStack = makeStack path
  propertyName = todoStack.pop()
  doneStack = []
  numChanges = 0
  while objName = todoStack.shift()
    doneStack.push objName
    return undefined unless object[objName]?
    unless isPlainObject object[objName]
      throw makeNotPlainObjectError doneStack
    object = object[objName]
  object[propertyName]

dd.set = (object, path, newValue) ->
  deepModify object, path, -> newValue

dd.increment = (object, path, amount=1) ->
  throw new Error "Supplied amount cannot be used as number." unless isNumber amount
  deepModify object, path, (oldValue) -> oldValue+amount

dd.decrement = (object, path, amount=1) ->
  throw new Error "Supplied amount cannot be used as number." unless isNumber amount
  deepModify object, path, (oldValue) -> value-amount

deepModify = (object, path, modifyFn) ->
  todoStack = makeStack path
  propertyName = todoStack.pop()
  doneStack = []
  numChanges = 0
  while objName = todoStack.shift()
    doneStack.push objName
    if object[objName]?
      unless isPlainObject object[objName]
        throw makeNotPlainObjectError doneStack
    else
      object[objName] = {}
      numChanges++
    object = object[objName]
  newValue = modifyFn object[propertyName]
  unless object[propertyName] is newValue
    object[propertyName] = newValue
    numChanges++
  numChanges

makeNotPlainObjectError = (doneStack) ->
  new Error "'#{getExpression("object", doneStack)}' is not a plain object."

makeStack = (path) ->
  if Array.isArray path
    stack = []
    for step in path
      if isString step
        stack.push step
      else
        throw new Error "path array contains a non-string"
    stack
  else if isString path
    if /^[a-z][A-z]*(\.[a-z][A-z]*)*$/.test path
      path.split "."
    else
      throw new Error "Invalid path '#{path}'"
  else
    throw new Error "Supplied path is not a string or an array."

getExpression = (objectName, steps) ->
  expression = objectName
  for step in steps
    if /^[A-z]+$/.test step
      expression += ".#{step}"
    else
      expression += "[#{step.toJSON()}]"
