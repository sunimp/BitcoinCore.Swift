//
//  SigHashType.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

public enum SigHashType {
    case bitcoinAll
    case bitcoinTaprootAll
    case bitcoinCashAll

    var value: UInt8 {
        switch self {
        case .bitcoinAll: 0x01
        case .bitcoinTaprootAll: 0x00
        case .bitcoinCashAll: 0x41
        }
    }

    var forked: Bool {
        switch self {
        case .bitcoinAll: false
        case .bitcoinTaprootAll: false
        case .bitcoinCashAll: true
        }
    }
}
