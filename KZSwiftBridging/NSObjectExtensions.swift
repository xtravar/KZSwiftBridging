//
//  NSObjectExtensions.swift
//  KZSwiftBridging
//
//  Created by Mike Kasianowicz on 7/31/15.
//  Copyright © 2015 Mike Kasianowicz. All rights reserved.
//

import Foundation

public extension NSObject {
// MARK: Generic
    /**
    Register an observer for the specified keypath, regardless of type. (simple)
    Use this method if you don't care about before/after, etc.
    If return value is not used, observation will cease when this object is deallocated.
    */
    func addObserver(keyPath: String, handler: ()->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = []
        let observer = KeyValueObjectObserver<NSObject>(object: self,
            keyPath: keyPath,
            options: opts)
        observer.changeHandler = {(_, _, _) in handler()}
        observer.startObserving()
        return observer
    }
    
// MARK: structs
    /**
    Register a struct observer for the specified keypath. (advanced)
    If return value is not used, observation will cease when this object is deallocated.
    
    :param: handler     A robust callback giving the old and new value, along with the change kind.
    :returns:           An opaque object which can control the observing.
    */
    func addObserver<Type: NSValueWrappable>(keyPath: String, handler: (kind: NSKeyValueChange, oldValue: Type?, newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New]
        let observer = KeyValueStructObserver<Type>(object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = handler
        observer.startObserving()
        return observer
    }
    
    /**
     Register a struct observer for the specified keypath. (simple)
     If return value is not used, observation will cease when this object is deallocated.
     
     :param: handler     A simple callback which will only return new values.
     :returns:           An opaque object which can control the observing
     */
    func addObserver<Type: NSValueWrappable>(keyPath: String, handler: (newValue: Type?) -> Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.New]
        let observer = KeyValueStructObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = {(_, _, newValue) in handler(newValue: newValue)}
        observer.startObserving()
        return observer
    }
    
// MARK: numbers
    /**
    Register a number observer for the specified keypath. (advanced)
    If return value is not used, observation will cease when this object is deallocated.
    
    :param: handler     A robust callback giving the old and new value, along with the change kind.
    :returns:           An opaque object which can control the observing
    */
    func addObserver<Type: NSNumberWrappable>(keyPath: String, handler: (kind: NSKeyValueChange, oldValue: Type?, newValue: Type?) -> Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New]
        let observer = KeyValueNumberObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = handler
        observer.startObserving()
        return observer
    }
    
    /**
     Register a number observer for the specified keypath. (simple)
     If return value is not used, observation will cease when this object is deallocated.
     
     :param: handler     A simple callback which will only return new values.
     :returns:           An opaque object which can control the observing
     */
    func addObserver<Type: NSNumberWrappable>(keyPath: String, handler: (newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.New]
        let observer = KeyValueNumberObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = {(_, _, newValue) in handler(newValue: newValue)}
        observer.startObserving()
        return observer
    }
    
// MARK: Objects
    /**
    Register an object observer for the specified keypath. (advanced)
    If return value is not used, observation will cease when this object is deallocated.
    
    :param: handler     A robust callback giving the old and new value, along with the change kind.
    :returns:           An opaque object which can control the observing
    */
    func addObserver<Type: NSObject>(keyPath: String, handler: (kind: NSKeyValueChange, oldValue: Type?, newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New]
        let observer = KeyValueObjectObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = handler
        observer.startObserving()
        return observer
    }
    
    /**
     Register an object observer for the specified keypath. (simple)
     If return value is not used, observation will cease when this object is deallocated.
     
     :param: handler     A simple callback which will only return new values.
     :returns:           An opaque object which can control the observing
     */
    func addObserver<Type: NSObject>(keyPath: String, handler: (newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.New]
        let observer = KeyValueObjectObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = {(_, _, newValue) in handler(newValue: newValue)}
        observer.startObserving()
        return observer
    }
    
// MARK: Enum and OptionSetType
    /**
    Register an enum observer for the specified keypath. (advanced)
    If return value is not used, observation will cease when this object is deallocated.
    
    :param: handler     A robust callback giving the old and new value, along with the change kind.
    :returns:           An opaque object which can control the observing
    */
    func addObserver<Type: RawRepresentable where Type.RawValue: NSNumberWrappable>(keyPath: String, handler: (kind: NSKeyValueChange, oldValue: Type?, newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New]
        let observer = KeyValueEnumObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = handler
        observer.startObserving()
        return observer
    }
    
    
    /**
     Register an enum observer observer for the specified keypath. (simple)
     If return value is not used, observation will cease when this object is deallocated.
     
     :param: handler     A simple callback which will only return new values.
     :returns:           An opaque object which can control the observing
     */
    func addObserver<Type: RawRepresentable where Type.RawValue: NSNumberWrappable>(keyPath: String, handler: (newValue: Type?)->Void) -> protocol<KeyValueObserver> {
        let opts: NSKeyValueObservingOptions = [NSKeyValueObservingOptions.New]
        let observer = KeyValueEnumObserver < Type > (object: self, keyPath: keyPath, options: opts)
        observer.changeHandler = {(_, _, newValue) in handler(newValue: newValue)}
        observer.startObserving()
        return observer
    }
}
