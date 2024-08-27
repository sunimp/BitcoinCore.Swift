//
//  PublicKeyFetcher.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import HDWalletKit

// MARK: - PublicKeyFetcher

class PublicKeyFetcher {
    private let hdAccountWallet: HDAccountWallet

    init(hdAccountWallet: HDAccountWallet) {
        self.hdAccountWallet = hdAccountWallet
    }
}

// MARK: IPublicKeyFetcher

extension PublicKeyFetcher: IPublicKeyFetcher {
    func publicKeys(indices: Range<UInt32>, external: Bool) throws -> [PublicKey] {
        try hdAccountWallet.publicKeys(indices: indices, external: external)
    }
}

// MARK: - WatchPublicKeyFetcher

class WatchPublicKeyFetcher {
    private let hdWatchAccountWallet: HDWatchAccountWallet

    init(hdWatchAccountWallet: HDWatchAccountWallet) {
        self.hdWatchAccountWallet = hdWatchAccountWallet
    }
}

// MARK: IPublicKeyFetcher

extension WatchPublicKeyFetcher: IPublicKeyFetcher {
    func publicKeys(indices: Range<UInt32>, external: Bool) throws -> [PublicKey] {
        try hdWatchAccountWallet.publicKeys(indices: indices, external: external)
    }
}

// MARK: - MultiAccountPublicKeyFetcher

class MultiAccountPublicKeyFetcher {
    private let hdWallet: HDWallet
    private(set) var currentAccount = 0

    init(hdWallet: HDWallet) {
        self.hdWallet = hdWallet
    }
}

// MARK: IPublicKeyFetcher, IMultiAccountPublicKeyFetcher

extension MultiAccountPublicKeyFetcher: IPublicKeyFetcher, IMultiAccountPublicKeyFetcher {
    func publicKeys(indices: Range<UInt32>, external: Bool) throws -> [PublicKey] {
        try hdWallet.publicKeys(account: currentAccount, indices: indices, external: external)
    }

    func increaseAccount() {
        currentAccount += 1
    }
}
