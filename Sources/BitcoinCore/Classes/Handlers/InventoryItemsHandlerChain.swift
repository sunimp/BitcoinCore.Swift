//
//  InventoryItemsHandlerChain.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class InventoryItemsHandlerChain: IInventoryItemsHandler {
    private var concreteHandlers = [IInventoryItemsHandler]()

    func handleInventoryItems(peer: IPeer, inventoryItems: [InventoryItem]) {
        for handler in concreteHandlers {
            handler.handleInventoryItems(peer: peer, inventoryItems: inventoryItems)
        }
    }

    func add(handler: IInventoryItemsHandler) {
        concreteHandlers.append(handler)
    }
}
