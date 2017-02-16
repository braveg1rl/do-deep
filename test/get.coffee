dd = require "../"
assert = require "assert"

testObject = 
  firstProperty: "firstValue"
  secondProperty: 
    firstNestedProperty: "firstNestedValue"
    secondNestedProperty: 
      firstTwiceNestedProperty: "firstTwiceNestedValue"
  thirdProperty: new Date

describe "get", ->
  it "should return a normal property", ->
    assert.equal (dd.get testObject, "firstProperty"), "firstValue"
  
  it "should return a nested property", ->
    assert.equal (dd.get testObject, "secondProperty.firstNestedProperty"), "firstNestedValue"
    
  it "should return a twice nested property", ->
    assert.equal (dd.get testObject, "secondProperty.secondNestedProperty.firstTwiceNestedProperty"), "firstTwiceNestedValue"