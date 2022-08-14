//
//  Generic.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            print("new value setted")
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        print("observable inition")
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        print("Connected new listener")
        closure(value)
        listener = closure
    }
}
