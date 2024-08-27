//
//  BlockSyncerState.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class BlockSyncerState {
    private(set) var iterationHasPartialBlocks = false

    func iteration(hasPartialBlocks state: Bool) {
        iterationHasPartialBlocks = state
    }
}
