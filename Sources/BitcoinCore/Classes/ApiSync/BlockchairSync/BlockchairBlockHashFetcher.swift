//
//  BlockchairBlockHashFetcher.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

public class BlockchairBlockHashFetcher: IBlockHashFetcher {
    private let blockchairApi: BlockchairApi

    public init(blockchairApi: BlockchairApi) {
        self.blockchairApi = blockchairApi
    }

    public func fetch(heights: [Int]) async throws -> [Int: String] {
        try await blockchairApi.blockHashes(heights: heights)
    }
}
