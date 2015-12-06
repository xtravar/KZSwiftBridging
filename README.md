# KZSwiftBridging

This is a framework specifically focused on bridging NSValue/NSNumber types more smoothly between Objective-C and Swift and vis-versa.

There are four unique components:

## Unifying NSNumber and NSValue conversion
All numeric types implement `NSNumberWrappable` and all common NSValue types implement `NSValueWrappable`.
```
public protocol NSNumberWrappable : NSValueWrappable {
    init(_ number: NSNumber)
    func toNSNumber() -> NSNumber
}
```

Additionally, inits have been added, especially handling the concept of nullable NSNumber -> optional Int
```
let nsnumber: NSNumber? = nil
if let intval = Int(nsnumber) {
  // ...
}
```

Note there's a Swift compiler issue which is why NSValue additions are slightly different.


##Treating NSDecimal as a first-class primitive
`NSDecimal` is a 128-bit struct that represents a decimal number.

Whereas one might typically use `NSDecimalNumber`, I felt it was in the spirit of Swift to fix the struct by adding `Equatable`, `Comparable`, and `SignedNumberType` conformance, as well as arithmatic operators.

Now you should be able to work on larger decimal types without having to create a class.


##Better Objective-C automated bridging
`CGPoint`, etc, and `NSDecimal`, now implement `_ObjectiveCBridgeable`.  `_ObjectiveCBridgeable` is a somewhat obfuscated protocol that allows one to specify special conversion of non-Objective-C types to Objective-C.  The primary use case here is to allow arrays, dictionaries, etc, to bridge appropriately.

##Typed key-value-observation additions to NSObject
Combined with all the pieces above, we get better bridging, which allows generics to better type KVO.  There are some new extensions on `NSObject` that allow a better, typed KVO experience.
