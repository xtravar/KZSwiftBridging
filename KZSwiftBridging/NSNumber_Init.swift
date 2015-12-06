//
//  NSNumberInit.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 12/2/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//


public extension NSNumber {
    //MARK: non-optional
    @nonobjc convenience public init(_ value: Int) {
        self.init(integer: value)
    }
    
    @nonobjc convenience public init(_ value: UInt) {
        self.init(unsignedInteger: value)
    }
    
    @nonobjc convenience public init(_ value: Int8) {
        self.init(char: value)
    }
    
    @nonobjc convenience public init(_ value: UInt8) {
        self.init(unsignedChar: value)
    }
    
    @nonobjc convenience public init(_ value: Int16) {
        self.init(short: value)
    }
    
    @nonobjc convenience public init(_ value: UInt16) {
        self.init(unsignedShort: value)
    }
    
    @nonobjc convenience public init(_ value: Int32) {
        self.init(int: value)
    }
    
    @nonobjc convenience public init(_ value: UInt32) {
        self.init(unsignedInt: value)
    }
    
    @nonobjc convenience public init(_ value: Int64) {
        self.init(longLong: value)
    }
    
    @nonobjc convenience public init(_ value: UInt64) {
        self.init(unsignedLongLong: value)
    }
    
    @nonobjc convenience public init(_ value: Float) {
        self.init(float: value)
    }
    
    @nonobjc convenience public init(_ value: Double) {
        self.init(double: value)
    }
    
    
    @nonobjc convenience public init(_ value: Bool) {
        self.init(bool: value)
    }

    
    
    
    //MARK: optional
    @nonobjc convenience public init?(_ optionalValue: Int?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(integer: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UInt?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(unsignedInteger: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Int8?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(char: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UInt8?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(unsignedChar: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Int16?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(short: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UInt16?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(unsignedShort: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Int32?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(int: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UInt32?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(unsignedInt: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Int64?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(longLong: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UInt64?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(unsignedLongLong: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Float?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(float: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Double?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(double: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: Bool?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(bool: value)
    }
}


public extension NSDecimalNumber {
    @nonobjc convenience init(_ value: NSDecimal) {
        self.init(decimal: value)
    }
    
    @nonobjc convenience init?(_ optionalValue: NSDecimal?) {
        guard let value = optionalValue else {
            return nil;
        }
        self.init(decimal: value)
    }
}