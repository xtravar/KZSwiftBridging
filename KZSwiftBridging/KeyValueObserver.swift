//
//  KeyValueObserver.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 7/6/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

import UIKit

public protocol KeyValueObserver {
    func startObserving()
    func stopObserving()
    func isObserving() -> Bool
}

internal class KeyValueObjectObserverBase<Type : NSObject> : NSObject, KeyValueObserver {
    // used as context and state
    private var _observing : Bool = false

    private(set) weak var object : NSObject!
    let keyPath : String
    let options : NSKeyValueObservingOptions

    init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
        self.object = object
        self.keyPath = keyPath
        self.options = options
    }

    func startObserving() {
        if _observing {
            return
        }
        
        // key just has to be unique
        objc_setAssociatedObject(self.object,
            &_observing,
            self,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        self.object.addObserver(self,
            forKeyPath: self.keyPath,
            options: self.options,
            context: nil)
        _observing = true
    }

    func stopObserving() {
        if !_observing {
            return
        }

        self.object.removeObserver(self,
            forKeyPath: self.keyPath,
            context: nil)


        objc_setAssociatedObject(self.object,
            &_observing,
            nil,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        _observing = false

    }
    
    func isObserving() -> Bool {
        return _observing
    }

    deinit {
        stopObserving()
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        guard let dict = change else {
            return;
        }

        let kindObj = dict[NSKeyValueChangeKindKey] as! NSNumber
        let kind = NSKeyValueChange(rawValue: kindObj.unsignedLongValue)!

        let newValue = dict[NSKeyValueChangeNewKey] as? Type
        let oldValue = dict[NSKeyValueChangeOldKey] as? Type
        didObserveChange(kind, oldValue: oldValue, newValue: newValue)
    }


    func didObserveChange(kind : NSKeyValueChange, oldValue: Type?, newValue: Type?) {
    }
}


internal class KeyValueObjectObserver<Type: NSObject> : KeyValueObjectObserverBase<Type> {
    var changeHandler = {(kind: NSKeyValueChange,  oldValue: Type?, newValue: Type?)->Void in }

    override init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
        super.init(object: object, keyPath: keyPath, options: options)
    }

    override func didObserveChange(kind: NSKeyValueChange, oldValue: Type?, newValue: Type?) {
        self.changeHandler(kind, oldValue, newValue)
    }
}

internal class KeyValueNumberObserver<Type: NSNumberWrappable> : KeyValueObjectObserverBase<NSNumber> {
    var changeHandler = {(kind: NSKeyValueChange,  oldValue: Type?, newValue: Type?)->Void in }

    override init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
        super.init(object: object, keyPath: keyPath, options: options)
    }

    override func didObserveChange(kind: NSKeyValueChange, oldValue: NSNumber?, newValue: NSNumber?) {
        let oldNum = Type(oldValue)
        let newNum = Type(newValue)
        self.changeHandler(kind, oldNum,  newNum)
    }
}

internal class KeyValueEnumObserver<Type: RawRepresentable where Type.RawValue: NSNumberWrappable> : KeyValueObjectObserverBase<NSNumber> {
    var changeHandler = {(kind: NSKeyValueChange,  oldValue: Type?, newValue: Type?)->Void in }

    override init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
        super.init(object: object, keyPath: keyPath, options: options)
    }

    override func didObserveChange(kind: NSKeyValueChange, oldValue: NSNumber?, newValue: NSNumber?) {
        typealias NumType = Type.RawValue
        var oldValueEnum : Type? = nil
        var newValueEnum : Type? = nil
        if let oldValueInt = NumType(oldValue) {
            oldValueEnum = Type(rawValue: oldValueInt)
        }
        if let newValueInt = NumType(newValue) {
            newValueEnum = Type(rawValue: newValueInt)
        }
        self.changeHandler(kind, oldValueEnum, newValueEnum)
    }
}


internal class KeyValueStructObserver<Type: NSValueWrappable>: KeyValueObjectObserverBase<NSValue> {
    var changeHandler = {(kind: NSKeyValueChange,  oldValue: Type?, newValue: Type?)->Void in }

    override init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
        super.init(object: object, keyPath: keyPath, options: options)
    }

    override func didObserveChange(kind: NSKeyValueChange, oldValue: NSValue?, newValue: NSValue?) {
        self.changeHandler(kind, Type(optionalValue: oldValue), Type(optionalValue: newValue))
    }
}



