//
//  TransactionMessage.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import WWExtensions

public struct TransactionMessage: IMessage {
    let transaction: FullTransaction
    let size: Int

    public init(transaction: FullTransaction, size: Int) {
        self.transaction = transaction
        self.size = size
    }

    public var description: String {
        "\(transaction.header.dataHash.ww.reversedHex)"
    }
}
