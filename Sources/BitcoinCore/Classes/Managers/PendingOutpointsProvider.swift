//
//  PendingOutpointsProvider.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

// MARK: - PendingOutpointsProvider

class PendingOutpointsProvider {
    private let storage: IStorage

    weak var bloomFilterManager: IBloomFilterManager?

    init(storage: IStorage) {
        self.storage = storage
    }
}

// MARK: IBloomFilterProvider

extension PendingOutpointsProvider: IBloomFilterProvider {
    func filterElements() -> [Data] {
        let hashes = storage.incomingPendingTransactionHashes()

        return storage.inputs(byHashes: hashes).map {
            $0.previousOutputTxHash + byteArrayLittleEndian(int: $0.previousOutputIndex)
        }
    }
}
