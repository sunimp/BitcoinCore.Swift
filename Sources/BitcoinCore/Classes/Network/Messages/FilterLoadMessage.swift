//
//  FilterLoadMessage.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

struct FilterLoadMessage: IMessage {
    let bloomFilter: BloomFilter

    init(bloomFilter: BloomFilter) {
        self.bloomFilter = bloomFilter
    }

    var description: String {
        "\(bloomFilter.elementsCount) item(s)"
    }
}
