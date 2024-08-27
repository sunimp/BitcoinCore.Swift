//
//  TransactionInfoConverter.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

open class TransactionInfoConverter: ITransactionInfoConverter {
    public var baseTransactionInfoConverter: IBaseTransactionInfoConverter!

    public init() { }

    public func transactionInfo(fromTransaction transactionForInfo: FullTransactionForInfo) -> TransactionInfo {
        baseTransactionInfoConverter.transactionInfo(fromTransaction: transactionForInfo)
    }
}
