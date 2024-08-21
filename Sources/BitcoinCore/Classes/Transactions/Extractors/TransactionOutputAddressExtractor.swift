//
//  TransactionOutputAddressExtractor.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import WWCryptoKit

class TransactionOutputAddressExtractor {
    private let storage: IStorage
    private let addressConverter: IAddressConverter

    init(storage: IStorage, addressConverter: IAddressConverter) {
        self.storage = storage
        self.addressConverter = addressConverter
    }
}

extension TransactionOutputAddressExtractor: ITransactionExtractor {
    public func extract(transaction: FullTransaction) {
        for output in transaction.outputs {
            guard let _payload = output.lockingScriptPayload else {
                continue
            }

            let payload: Data
            switch output.scriptType {
            case .p2pk:
                // If the scriptType is P2PK, we generate Address as if it was P2PKH
                payload = Crypto.ripeMd160Sha256(_payload)
            default: payload = _payload
            }

            let scriptType = output.scriptType
            if let address = try? addressConverter.convert(lockingScriptPayload: payload, type: scriptType) {
                output.address = address.stringValue
            }
        }
    }
}
