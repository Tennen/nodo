//
//  Timer.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/21.
//

import Foundation
import Combine

class SlotTimer {
    var currentTimePublisher = Timer.publish(every: 0.1, on: .main, in: .common)
    var cancelable: AnyCancellable?
    
    func connectTimer() {
        if (cancelable == nil) {
            cancelable = currentTimePublisher.connect() as? AnyCancellable
        }
    }
    
    func cancelTimer() {
        cancelable?.cancel()
        cancelable = nil
    }

}

let timer = SlotTimer()
