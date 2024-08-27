//
//  Address.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

// MARK: - AddressType

public enum AddressType: UInt8 { case pubKeyHash = 0, scriptHash = 8 }

// MARK: - Address

public protocol Address: AnyObject {
    var scriptType: ScriptType { get }
    var lockingScriptPayload: Data { get }
    var stringValue: String { get }
    var lockingScript: Data { get }
}

// MARK: - LegacyAddress

public class LegacyAddress: Address, Equatable {
    public let type: AddressType
    public let lockingScriptPayload: Data
    public let stringValue: String

    public var scriptType: ScriptType {
        switch type {
        case .pubKeyHash: .p2pkh
        case .scriptHash: .p2sh
        }
    }

    public var lockingScript: Data {
        switch type {
        case .pubKeyHash: OpCode.p2pkhStart + OpCode.push(lockingScriptPayload) + OpCode.p2pkhFinish
        case .scriptHash: OpCode.p2shStart + OpCode.push(lockingScriptPayload) + OpCode.p2shFinish
        }
    }

    public init(type: AddressType, payload: Data, base58: String) {
        self.type = type
        lockingScriptPayload = payload
        stringValue = base58
    }

    public static func == (lhs: LegacyAddress, rhs: some Address) -> Bool {
        guard let rhs = rhs as? LegacyAddress else {
            return false
        }
        return lhs.type == rhs.type && lhs.lockingScriptPayload == rhs.lockingScriptPayload
    }
}
