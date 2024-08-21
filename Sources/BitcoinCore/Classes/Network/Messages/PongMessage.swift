//
//  PongMessage.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

/// The pong message is sent in response to a ping message.
/// In modern protocol versions, a pong response is generated using a nonce included in the ping.
struct PongMessage: IMessage {
    /// nonce from ping
    let nonce: UInt64

    var description: String {
        "\(nonce)"
    }
}
