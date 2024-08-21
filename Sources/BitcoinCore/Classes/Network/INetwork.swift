//
//  INetwork+.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

extension INetwork {
    
    public var protocolVersion: Int32 { 70015 }
    public var maxBlockSize: UInt32 { 1_000_000 }
    public var serviceFullNode: UInt64 { 1 }

    public var bip44Checkpoint: Checkpoint {
        try! Checkpoint(bundleName: bundleName, network: String(describing: type(of: self)), blockType: .bip44)
    }

    public var lastCheckpoint: Checkpoint {
        try! Checkpoint(bundleName: bundleName, network: String(describing: type(of: self)), blockType: .last)
    }
}
