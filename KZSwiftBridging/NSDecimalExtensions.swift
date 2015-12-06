//
//  NSDecimalExtensions.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 12/1/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

extension NSDecimal {
    public init(mantissa: UInt64, exponent: Int16, isNegative: Bool) {
        self = NSDecimalNumber(mantissa: mantissa, exponent: exponent, isNegative: isNegative).decimalValue
    }
}

//MARK: equatable/comparable
extension NSDecimal: Equatable, Comparable {
}

public func ==(var lhs: NSDecimal, var rhs: NSDecimal) -> Bool {
    let result = NSDecimalCompare(&lhs, &rhs)
    return result == .OrderedSame
}

public func <(var lhs: NSDecimal, var rhs: NSDecimal) -> Bool {
    let result = NSDecimalCompare(&lhs, &rhs)
    return result == .OrderedAscending
}

public func <=(var lhs: NSDecimal, var rhs: NSDecimal) -> Bool {
    let result = NSDecimalCompare(&lhs, &rhs)
    return result != .OrderedDescending
}

public func >=(var lhs: NSDecimal, var rhs: NSDecimal) -> Bool {
    let result = NSDecimalCompare(&lhs, &rhs)
    return result != .OrderedAscending
}

public func >(var lhs: NSDecimal, var rhs: NSDecimal) -> Bool {
    let result = NSDecimalCompare(&lhs, &rhs)
    return result == .OrderedDescending
}

//MARK: other operators
public func +(var lhs: NSDecimal, var rhs: NSDecimal) -> NSDecimal {
    var result = NSDecimal()
    NSDecimalAdd(&result, &lhs, &rhs, .RoundPlain)
    return result
}

public func -(var lhs: NSDecimal, var rhs: NSDecimal) -> NSDecimal {
    var result = NSDecimal()
    NSDecimalSubtract(&result, &lhs, &rhs, .RoundPlain)
    return result
}

public func *(var lhs: NSDecimal, var rhs: NSDecimal) -> NSDecimal {
    var result = NSDecimal()
    NSDecimalMultiply(&result, &lhs, &rhs, .RoundPlain)
    return result
}

public func /(var lhs: NSDecimal, var rhs: NSDecimal) -> NSDecimal {
    var result = NSDecimal()
    NSDecimalDivide(&result, &lhs, &rhs, .RoundPlain)
    return result
}

//MARK: FloatingPointType
extension NSDecimal: FloatingPointType {
    
    public init(_ value: UInt8) {
        self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
    }
    
    public init(_ value: Int8) {
        if value < 0 {
            self.init(mantissa: UInt64(-value), exponent: 0, isNegative: true)
        } else {
            self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
        }
    }
    
    public init(_ value: UInt16) {
        self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
    }
    
    public init(_ value: Int16) {
        if value < 0 {
            self.init(mantissa: UInt64(-value), exponent: 0, isNegative: true)
        } else {
            self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
        }
    }
    
    public init(_ value: UInt32) {
        self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
    }
    
    public init(_ value: Int32) {
        if value < 0 {
            self.init(mantissa: UInt64(-value), exponent: 0, isNegative: true)
        } else {
            self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
        }
    }
    
    public init(_ value: UInt64) {
        self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
    }
    
    public init(_ value: Int64) {
        if value < 0 {
            self.init(mantissa: UInt64(-value), exponent: 0, isNegative: true)
        } else {
            self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
        }
    }
    
    public init(_ value: UInt) {
        self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
    }
    
    public init(_ value: Int) {
        if value < 0 {
            self.init(mantissa: UInt64(-value), exponent: 0, isNegative: true)
        } else {
            self.init(mantissa: UInt64(value), exponent: 0, isNegative: false)
        }
    }
    
    public static var infinity: NSDecimal = NSNumber(double: Double.infinity).decimalValue
    
    public static var NaN: NSDecimal = NSDecimalNumber.notANumber().decimalValue
    
    public static var quietNaN: NSDecimal = NSNumber(double: Double.quietNaN).decimalValue
    
    public var floatingPointClass: FloatingPointClassification { return NSDecimalNumber(decimal: self).doubleValue.floatingPointClass }
    
    public var isSignMinus: Bool { return self._isNegative != 0 }
    
    public var isNormal: Bool { return NSDecimalNumber(decimal: self).doubleValue.isNormal }
    public var isFinite: Bool { return NSDecimalNumber(decimal: self).doubleValue.isFinite }
    public var isZero: Bool { return NSDecimalNumber(decimal: self).doubleValue.isZero }
    public var isSubnormal: Bool { return NSDecimalNumber(decimal: self).doubleValue.isSubnormal }
    public var isInfinite: Bool { return self == NSDecimal.infinity }
    public var isNaN: Bool {
        var x = self
        return NSDecimalIsNotANumber(&x)
    }
    
    public var isSignaling: Bool { return NSDecimalNumber(decimal: self).doubleValue.isSignaling }
}

//MARK: Strideable
extension NSDecimal : Strideable {
    public typealias _BitsType = (UInt64, UInt64)
    public static func _fromBitPattern(bits: _BitsType) -> NSDecimal {
        return unsafeBitCast(bits, NSDecimal.self)
    }
    public func _toBitPattern() -> _BitsType {
        return unsafeBitCast(self, (UInt64, UInt64).self)
    }
    
    
    public typealias Stride = NSDecimal
    public func distanceTo(other: NSDecimal) -> Stride {
        return other - self
    }

    public func advancedBy(n: Stride) -> NSDecimal {
        return self + n
    }
}

//MARK: SignedNumberType, Literals
extension NSDecimal : SignedNumberType, IntegerLiteralConvertible, FloatLiteralConvertible {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
    
    public init(floatLiteral value: Double) {
        self = NSDecimalNumber(double: value).decimalValue
    }
}

prefix public func -(x: NSDecimal) -> NSDecimal {
    var retval = x
    retval._isNegative = x.isSignMinus ? 0 : 1
    return retval
}


//MARK: CustomStringConvertable
extension NSDecimal : CustomStringConvertible {
    public func descriptionWithLocale(locale: NSLocale?) -> String {
        var x = self
        return NSDecimalString(&x, locale)
    }
    
    public var description: String {
        return self.descriptionWithLocale(nil)
    }
}

public func pow(var number: NSDecimal, power: Int, roundingMode: NSRoundingMode = .RoundPlain) -> NSDecimal {
    var retval = NSDecimal()
    NSDecimalPower(&retval, &number, power, roundingMode)
    return retval
}

public func pow(var number: NSDecimal, power: Int16, roundingMode: NSRoundingMode = .RoundPlain) -> NSDecimal {
    var retval = NSDecimal()
    NSDecimalMultiplyByPowerOf10(&retval, &number, power, roundingMode)
    return retval
}



//MARK: swift-objc automatic bridging

extension NSDecimal : _ObjectiveCBridgeable {
    public typealias _ObjectiveCType = NSDecimalNumber
    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    
    public static func _getObjectiveCType() -> Any.Type {
        return NSDecimalNumber.self
    }
    
    public func _bridgeToObjectiveC() -> NSDecimalNumber {
        return NSDecimalNumber(decimal: self)
    }
    
    public static func _forceBridgeFromObjectiveC(source: NSDecimalNumber, inout result: NSDecimal?) {
        result = source.decimalValue
    }
    
    public static func _conditionallyBridgeFromObjectiveC(source: NSDecimalNumber, inout result: NSDecimal?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}