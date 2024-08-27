//
//  BloomFilterManager.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

// MARK: - BloomFilterManager

class BloomFilterManager {
    class BloomFilterExpired: Error { }

    private var providers = [IBloomFilterProvider]()

    private let factory: IFactory
    weak var delegate: IBloomFilterManagerDelegate?

    var bloomFilter: BloomFilter?

    init(factory: IFactory) {
        self.factory = factory
    }
}

// MARK: IBloomFilterManager

extension BloomFilterManager: IBloomFilterManager {
    func add(provider: IBloomFilterProvider) {
        provider.bloomFilterManager = self
        providers.append(provider)
    }

    func regenerateBloomFilter() {
        var elements = [Data]()

        for provider in providers {
            elements.append(contentsOf: provider.filterElements())
        }

        if !elements.isEmpty {
            bloomFilter = factory.bloomFilter(withElements: elements)
            delegate?.bloomFilterUpdated(bloomFilter: bloomFilter!)
        }
    }
}
