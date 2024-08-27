//
//  MutableTransaction.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

public class MutableTransaction {
    var transaction = Transaction(version: 2, lockTime: 0)
    var inputsToSign = [InputToSign]()
    var outputs = [Output]()

    public var recipientAddress: Address!
    public var recipientValue = 0
    var memo: String?
    var changeAddress: Address?
    var changeValue = 0

    private(set) var pluginData = [UInt8: Data]()

    var pluginDataOutputSize: Int {
        !pluginData.isEmpty ? 1 + pluginData.reduce(into: 0) { $0 += 1 + $1.value.count } : 0 // OP_RETURN (PLUGIN_ID PLUGIN_DATA)
    }

    public init(outgoing: Bool = true) {
        transaction.status = .new
        transaction.isMine = true
        transaction.isOutgoing = outgoing
    }

    public func add(pluginData: Data, pluginId: UInt8) {
        self.pluginData[pluginId] = pluginData
    }

    func add(inputToSign: InputToSign) {
        inputsToSign.append(inputToSign)
    }

    public func build() -> FullTransaction {
        FullTransaction(header: transaction, inputs: inputsToSign.map(\.input), outputs: outputs)
    }
}
