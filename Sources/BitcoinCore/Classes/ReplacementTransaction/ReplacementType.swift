//
//  ReplacementType.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

public enum ReplacementType {
    case speedUp
    case cancel(address: Address, publicKey: PublicKey)
}
