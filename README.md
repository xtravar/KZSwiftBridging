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
`NSDecimal` is a 128-bit struct that represents a decimal number.  Whereas one might use `NSDecimalNumber` for convenience, I felt it was in the spirit of Swift to fix the struct by adding `Equatable`, `Comparable`, and `SignedNumberType` conformance.  Now you should be able to work on larger decimal types without having to create classes.


##Better Objective-C automated bridging
`CGPoint` and anything else that implements `NSValueBridgeable`, and NSDecimal, now implement `_ObjectiveCBridgeable`, so arrays an dictionaries of them will be represented in Objective-C as arrays of either `NSValue` or `NSDecimalNumber` respectively.

##Typed key-value-observation additions to NSObject
With better bridging, I've introduced some KVO-change handlers that allow you to strongly type your key-value-observation experience on `NSObject`.
