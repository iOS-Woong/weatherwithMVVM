//
//  Observable.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    var listner: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(onNext: @escaping (T) -> Void) {
        onNext(value)
        self.listner = onNext
    }
    
}
