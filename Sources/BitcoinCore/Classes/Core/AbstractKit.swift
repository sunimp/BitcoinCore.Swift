//
//  AbstractKit.swift
//
//  Created by Sun on 2019/4/3.
//

import Foundation

open class AbstractKit {
    // MARK: Properties

    public var bitcoinCore: BitcoinCore
    public var network: INetwork

    // MARK: Computed Properties

    open var lastBlockInfo: BlockInfo? {
        bitcoinCore.lastBlockInfo
    }

    open var balance: BalanceInfo {
        bitcoinCore.balance
    }

    open var syncState: BitcoinCore.KitState {
        bitcoinCore.syncState
    }

    open var debugInfo: String {
        bitcoinCore.debugInfo(network: network)
    }

    open var statusInfo: [(String, Any)] {
        bitcoinCore.statusInfo
    }

    public var watchAccount: Bool {
        bitcoinCore.watchAccount
    }

    // MARK: Lifecycle

    public init(bitcoinCore: BitcoinCore, network: INetwork) {
        self.bitcoinCore = bitcoinCore
        self.network = network
    }

    // MARK: Functions

    open func start() {
        bitcoinCore.start()
    }

    open func stop() {
        bitcoinCore.stop()
    }

    open func transactions(
        fromUid: String? = nil,
        type: TransactionFilterType?,
        limit: Int? = nil
    )
        -> [TransactionInfo] {
        bitcoinCore.transactions(fromUid: fromUid, type: type, limit: limit)
    }

    open func transaction(hash: String) -> TransactionInfo? {
        bitcoinCore.transaction(hash: hash)
    }

    open func send(params: SendParameters) throws -> FullTransaction {
        try bitcoinCore.send(params: params)
    }

    open func createRawTransaction(params: SendParameters) throws -> Data {
        try bitcoinCore.createRawTransaction(params: params)
    }

    open func validate(address: String, pluginData: [UInt8: IPluginData] = [:]) throws {
        try bitcoinCore.validate(address: address, pluginData: pluginData)
    }

    open func parse(paymentAddress: String) -> BitcoinPaymentData {
        bitcoinCore.parse(paymentAddress: paymentAddress)
    }

    open func sendInfo(params: SendParameters) throws -> BitcoinSendInfo {
        if params.address == nil {
            let publicKey = try bitcoinCore.changePublicKey()
            params.address = try bitcoinCore.address(from: publicKey).stringValue
        }

        return try bitcoinCore.sendInfo(params: params)
    }

    open func maxSpendableValue(params: SendParameters) throws -> Int {
        if params.address == nil {
            let publicKey = try bitcoinCore.changePublicKey()
            params.address = try bitcoinCore.address(from: publicKey).stringValue
        }

        return try bitcoinCore.maxSpendableValue(params: params)
    }

    open func maxSpendLimit(pluginData: [UInt8: IPluginData]) throws -> Int? {
        try bitcoinCore.maxSpendLimit(pluginData: pluginData)
    }

    open func minSpendableValue(params: SendParameters) throws -> Int {
        try bitcoinCore.minSpendableValue(params: params)
    }

    open func unspentOutputs(filters: UtxoFilters) -> [UnspentOutputInfo] {
        bitcoinCore.unspentOutputs(filters: filters).map(\.info)
    }

    open func receiveAddress() -> String {
        bitcoinCore.receiveAddress()
    }

    open func usedAddresses(change: Bool) -> [UsedAddress] {
        bitcoinCore.usedAddresses(change: change)
    }

    open func changePublicKey() throws -> PublicKey {
        try bitcoinCore.changePublicKey()
    }

    open func receivePublicKey() throws -> PublicKey {
        try bitcoinCore.receivePublicKey()
    }

    open func watch(transaction: BitcoinCore.TransactionFilter, delegate: IWatchedTransactionDelegate) {
        bitcoinCore.watch(transaction: transaction, delegate: delegate)
    }

    public func send(to hash: Data, scriptType: ScriptType, params: SendParameters) throws -> FullTransaction {
        params.address = try bitcoinCore.address(fromHash: hash, scriptType: scriptType).stringValue

        return try bitcoinCore.send(params: params)
    }

    public func redeem(from unspentOutput: UnspentOutput, params: SendParameters) throws -> FullTransaction {
        try bitcoinCore.redeem(from: unspentOutput, params: params)
    }

    public func publicKey(byPath path: String) throws -> PublicKey {
        try bitcoinCore.publicKey(byPath: path)
    }

    public func rawTransaction(transactionHash: String) -> String? {
        bitcoinCore.rawTransaction(transactionHash: transactionHash)
    }

    public func speedUpTransaction(transactionHash: String, minFee: Int) throws -> ReplacementTransaction {
        try bitcoinCore.replacementTransaction(transactionHash: transactionHash, minFee: minFee, type: .speedUp)
    }

    public func cancelTransaction(transactionHash: String, minFee: Int) throws -> ReplacementTransaction {
        let publicKey = try bitcoinCore.receivePublicKey()
        return try bitcoinCore.replacementTransaction(
            transactionHash: transactionHash,
            minFee: minFee,
            type: .cancel(address: bitcoinCore.address(from: publicKey), publicKey: publicKey)
        )
    }

    public func send(replacementTransaction: ReplacementTransaction) throws -> FullTransaction {
        try bitcoinCore.send(replacementTransaction: replacementTransaction)
    }

    public func speedUpTransactionInfo(transactionHash: String)
        -> (originalTransactionSize: Int, feeRange: Range<Int>)? {
        bitcoinCore.replacmentTransactionInfo(transactionHash: transactionHash, type: .speedUp)
    }

    public func cancelTransactionInfo(transactionHash: String)
        -> (originalTransactionSize: Int, feeRange: Range<Int>)? {
        if
            let receivePublicKey = try? bitcoinCore.receivePublicKey(),
            let address = try? bitcoinCore.address(from: receivePublicKey) {
            bitcoinCore.replacmentTransactionInfo(
                transactionHash: transactionHash,
                type: .cancel(address: address, publicKey: receivePublicKey)
            )
        } else {
            nil
        }
    }
}
