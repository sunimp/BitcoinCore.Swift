//
//  BiApiBlockProvider.swift
//
//  Created by Sun on 2023/10/27.
//

import Foundation

public class BiApiBlockProvider: IApiTransactionProvider {
    // MARK: Properties

    private let restoreProvider: IApiTransactionProvider
    private let syncProvider: IApiTransactionProvider
    private let apiSyncStateManager: ApiSyncStateManager

    // MARK: Lifecycle

    public init(
        restoreProvider: IApiTransactionProvider,
        syncProvider: IApiTransactionProvider,
        apiSyncStateManager: ApiSyncStateManager
    ) {
        self.restoreProvider = restoreProvider
        self.syncProvider = syncProvider
        self.apiSyncStateManager = apiSyncStateManager
    }

    // MARK: Functions

    public func transactions(addresses: [String], stopHeight: Int?) async throws -> [ApiTransactionItem] {
        apiSyncStateManager.restored
            ? try await syncProvider.transactions(addresses: addresses, stopHeight: stopHeight)
            : try await restoreProvider.transactions(addresses: addresses, stopHeight: stopHeight)
    }
}
