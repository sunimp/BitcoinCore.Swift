//
//  InventoryMessage.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import WWExtensions

/// Allows a node to advertise its knowledge of one or more objects. It can be received unsolicited, or in reply to getblocks.
struct InventoryMessage: IMessage {
    /// Number of inventory entries
    let count: VarInt
    /// Inventory vectors
    let inventoryItems: [InventoryItem]

    init(inventoryItems: [InventoryItem]) {
        count = VarInt(inventoryItems.count)
        self.inventoryItems = inventoryItems
    }

    var description: String {
        let items = inventoryItems.map { item in
            let objectTypeString =
                if case .unknown = item.objectType {
                    String(item.type)
                } else {
                    "\(item.objectType)"
                }
            return "[\(objectTypeString): \(item.hash.ww.reversedHex)]"
        }.joined(separator: ", ")

        return "\(items)"
    }
}
