//
//  NSValue_Init.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 12/2/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public extension NSValue {
    //MARK: non-optional
    @nonobjc convenience public init(_ value: CGPoint) {
        self.init(CGPoint: value)
    }
    
    @nonobjc convenience public init(_ value: CGVector) {
        self.init(CGVector: value)
    }
    
    @nonobjc convenience public init(_ value: CGSize) {
        self.init(CGSize: value)
    }
    
    @nonobjc convenience public init(_ value: CGRect) {
        self.init(CGRect: value)
    }
    
    @nonobjc convenience public init(_ value: CGAffineTransform) {
        self.init(CGAffineTransform: value)
    }
    
    @nonobjc convenience public init(_ value: UIEdgeInsets) {
        self.init(UIEdgeInsets: value)
    }
    
    @nonobjc convenience public init(_ value: UIOffset) {
        self.init(UIOffset: value)
    }
    
    
    //MARK: optional
    @nonobjc convenience public init?(_ optionalValue: CGPoint?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(CGPoint: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: CGVector?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(CGVector: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: CGSize?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(CGSize: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: CGRect?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(CGRect: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: CGAffineTransform?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(CGAffineTransform: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UIEdgeInsets?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(UIEdgeInsets: value)
    }
    
    @nonobjc convenience public init?(_ optionalValue: UIOffset?) {
        guard let value = optionalValue else {
            return nil
        }
        self.init(UIOffset: value)
    }
}