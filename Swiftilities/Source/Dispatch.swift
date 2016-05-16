//
//  Dispatch.swift
//
// Thank you John Sundell: 
// https://github.com/JohnSundell/SwiftKit/blob/master/Source/Shared/Dispatch.swift

import Foundation

/// Typealias for closures that take Void input and produce Void output
public typealias VoidClosure = Void -> Void

/// Execute an automatically generated closure on the Application's main queue
public func onMainQueue(@autoclosure(escaping) closure: VoidClosure) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

/// Execute a closure on the Application's main queue (either sync or async)
public func onMainQueue(closure: VoidClosure) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

/// Execute a closure asynchronously on a given queue
public func async(queue: dispatch_queue_t, closure: VoidClosure) {
    dispatch_async(queue, closure)
}

/// Execute a closure asynchronously on a new serial background queue with a given label
public func async(queueLabel: String, closure: VoidClosure) {
    async(dispatch_queue_create(queueLabel, nil), closure: closure)
}

/// Delay a closure by n number of seconds (and perform it on the Application's main queue)
public func delay(delay: NSTimeInterval, executeClosure closure: VoidClosure) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue(), closure)
}