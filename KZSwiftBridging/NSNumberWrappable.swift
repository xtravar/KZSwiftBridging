//
//  NSNumberWrappable.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 7/31/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

import Foundation
import UIKit

/**
 Denotes that a type can be wrapped (boxed) as an NSNumber (and consequentially NSValue)
 */
public protocol NSNumberWrappable : NSValueWrappable {
    init(_ number: NSNumber)
    func toNSNumber() -> NSNumber
}

extension NSNumberWrappable {
    @nonobjc public init(value: NSValue) {
        self.init(value as! NSNumber)
    }
    
    public func toNSValue() -> NSValue {
        return self.toNSNumber()
    }
}

extension NSNumberWrappable {
    @nonobjc public init?(_ optionalNumber: NSNumber?) {
        guard let number = optionalNumber else {
            return nil
        }
        
        self.init(number)
    }
}


//MARK: Integer 8-bit
extension Int8 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.charValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(char: self)
    }
}

extension UInt8 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.unsignedCharValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(unsignedChar: self)
    }
}

//MARK: Integer 16-bit
extension Int16 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.shortValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(short: self)
    }
}

extension UInt16 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.unsignedShortValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(unsignedShort: self)
    }
}

//MARK: Integer 32-bit
extension Int32 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.intValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(int: self)
    }
}

extension UInt32 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.unsignedIntValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(unsignedInt: self)
    }
}


//MARK: Integer 64-bit
extension Int64 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.longLongValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(longLong: self)
    }
}

extension UInt64 : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.unsignedLongLongValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(unsignedLongLong: self)
    }
}


//MARK: Float
extension Float : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.floatValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(float: self)
    }
}

extension Double : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.doubleValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(double: self)
    }
}

//MARK: Bool
extension Bool : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.boolValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(bool: self)
    }
}

//MARK: Integer
extension Int : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.integerValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(integer: self)
    }
}

extension UInt : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.unsignedIntegerValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSNumber(unsignedInteger: self)
    }
}

//MARK: decimal
extension NSDecimal : NSNumberWrappable {
    public init(_ number: NSNumber) {
        self = number.decimalValue
    }
    
    public func toNSNumber() -> NSNumber {
        return NSDecimalNumber(decimal: self)
    }
    
    public var hashValue: Int { return self.description.hashValue }
}

extension NSDecimal {
    public init(_ number: NSDecimalNumber) {
        self = number.decimalValue
    }
    
    public init?(_ optionalNumber: NSDecimalNumber?) {
        guard let number = optionalNumber else {
            return nil
        }
        
        self.init(number)
    }
}