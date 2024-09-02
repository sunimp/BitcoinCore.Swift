//
//  TransactionMessage.swift
//
//  Created by Sun on 2018/9/4.
//

import Foundation

import WWExtensions

public struct TransactionMessage: IMessage {
    // MARK: Properties

    let transaction: FullTransaction
    let size: Int

    // MARK: Computed Properties

    public var description: String {
        "\(transaction.header.dataHash.ww.reversedHex)"
    }

    // MARK: Lifecycle

    public init(transaction: FullTransaction, size: Int) {
        self.transaction = transaction
        self.size = size
    }
}
