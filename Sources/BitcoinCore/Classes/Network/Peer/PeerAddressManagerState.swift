//
//  PeerAddressManagerState.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class PeerAddressManagerState {
    private(set) var usedIps: [String] = []

    func add(usedIp: String) {
        usedIps.append(usedIp)
    }

    func remove(usedIp: String) {
        usedIps.removeAll(where: { $0 == usedIp })
    }
}
