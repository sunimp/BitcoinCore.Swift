//
//  BlockchairLastBlockProvider.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

public class BlockchairLastBlockProvider {
    private let blockchairApi: BlockchairApi

    public init(blockchairApi: BlockchairApi) {
        self.blockchairApi = blockchairApi
    }

    public func lastBlockHeader() async throws -> ApiBlockHeaderItem {
        try await blockchairApi.lastBlockHeader()
    }
}
