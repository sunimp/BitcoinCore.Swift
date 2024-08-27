//
//  TransactionSendTimer.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

// MARK: - TransactionSendTimer

class TransactionSendTimer {
    let interval: TimeInterval

    weak var delegate: ITransactionSendTimerDelegate? = nil
    var runLoop: RunLoop? = nil
    var timer: Timer? = nil

    init(interval: TimeInterval) {
        self.interval = interval
    }
}

// MARK: ITransactionSendTimer

extension TransactionSendTimer: ITransactionSendTimer {
    func startIfNotRunning() {
        guard runLoop == nil else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            self.runLoop = .current

            let timer = Timer(
                timeInterval: self.interval,
                repeats: true,
                block: { [weak self] _ in self?.delegate?.timePassed() }
            )
            self.timer = timer

            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
    }

    func stop() {
        if let runLoop {
            timer?.invalidate()
            timer?.invalidate()

            CFRunLoopStop(runLoop.getCFRunLoop())
            timer = nil
            self.runLoop = nil
        }
    }
}
