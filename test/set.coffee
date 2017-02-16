dd = require "../"
assert = require "assert"

testObject = 
  firstProperty: "firstValue"
  secondProperty: 
    firstNestedProperty: "firstNestedValue"
    secondNestedProperty: 
      firstTwiceNestedProperty: "firstTwiceNestedValue"
  thirdProperty: new Date

describe "set", ->
  it "should set a normal property", ->
    dd.set testObject, "firstProperty", "firstNewValue"
    assert.equal testObject.firstProperty, "firstNewValue"
    
  it "should set a nested property", ->
    dd.set testObject, "secondProperty.firstNestedProperty", "firstNewNestedValue"
    assert.equal testObject.secondProperty.firstNestedProperty, "firstNewNestedValue"
    
  it "should set a twice nested property", ->
    dd.set testObject, "secondProperty.secondNestedProperty.firstTwiceNestedProperty", "firstNewTwiceNestedValue"
    assert.equal testObject.secondProperty.secondNestedProperty.firstTwiceNestedProperty, "firstNewTwiceNestedValue"
    
  it "should return the number of changes that were made", ->
    numChanges = dd.set {}, "a", "b"    
    assert.equal numChanges, 1
    numChanges = dd.set {}, "a.b.c.d", "e"
    assert.equal numChanges, 4
    