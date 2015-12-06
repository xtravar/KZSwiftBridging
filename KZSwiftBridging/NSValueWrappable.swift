//
//  NSValueWrappable.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 7/31/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

import Foundation
import UIKit


/**
 Denotes that a type can be wrapped (boxed) as an NSValue
 */
public protocol NSValueWrappable: Hashable {
    init(value: NSValue)
    func toNSValue() -> NSValue
}



public extension Optional where Wrapped : NSValueWrappable {
    public init(optionalValue: NSValue?) {
        guard let value = optionalValue else {
            self = .None
            return
        }
        
        self = .Some(Wrapped(value: value))
    }
    
    public func toOptionalNSValue() -> NSValue? {
        if case .Some(let value) = self {
            return value.toNSValue()
        }
        return nil
    }
}


public extension NSValueWrappable {
    public init?(optionalValue: NSValue?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(value: value)
    }
}

//MARK: Core Graphics structs
extension CGPoint : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.CGPointValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(CGPoint: self)
    }
    
    public var description: String { return NSStringFromCGPoint(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}


extension CGVector : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.CGVectorValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(CGVector: self)
    }
    
    public var description: String { return NSStringFromCGVector(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}


extension CGSize : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.CGSizeValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(CGSize: self)
    }
    
    public var description: String { return NSStringFromCGSize(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}


extension CGRect : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.CGRectValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(CGRect: self)
    }
    
    public var description: String { return NSStringFromCGRect(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}

extension CGAffineTransform : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.CGAffineTransformValue()
    }
        
    public func toNSValue() -> NSValue {
        return NSValue(CGAffineTransform: self)
    }
    
    public var description: String { return NSStringFromCGAffineTransform(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}

public func ==(lhs: CGAffineTransform, rhs: CGAffineTransform) -> Bool {
    return CGAffineTransformEqualToTransform(lhs, rhs)
}

//MARK: UIKit structs
extension UIEdgeInsets : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.UIEdgeInsetsValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(UIEdgeInsets: self)
    }
    
    public var description: String { return NSStringFromUIEdgeInsets(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}

extension UIOffset : NSValueWrappable, NSValueBridgeable, CustomStringConvertible {
    public init(value: NSValue) {
        self = value.UIOffsetValue()
    }
    
    public func toNSValue() -> NSValue {
        return NSValue(UIOffset: self)
    }
    
    public var description: String { return NSStringFromUIOffset(self) }
    
    public var hashValue: Int { return self.description.hashValue }
}


//MARK: swift-objc automatic bridging
public protocol NSValueBridgeable : NSValueWrappable, _ObjectiveCBridgeable {
    //this has to go here because swift compiler crashes
    typealias _ObjectiveCType = NSValue
}

extension NSValueBridgeable {
    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    
    public static func _getObjectiveCType() -> Any.Type {
        return NSValue.self
    }
    
    public func _bridgeToObjectiveC() -> NSValue {
        return self.toNSValue()
    }
    
    public static func _forceBridgeFromObjectiveC(source: NSValue, inout result: Self?) {
        memset(&result, 0, sizeof(Self?))
        source.getValue(&result)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(source: NSValue, inout result: Self?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}
