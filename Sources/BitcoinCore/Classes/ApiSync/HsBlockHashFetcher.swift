//
//  HsBlockHashFetcher.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import Alamofire
import ObjectMapper
import WWToolKit

// MARK: - HsBlockHashFetcher

public class HsBlockHashFetcher: IBlockHashFetcher {
    private static let paginationLimit = 100

    private let hsURL: String
    private let networkManager: NetworkManager

    public init(hsURL: String, logger: Logger? = nil) {
        self.hsURL = hsURL
        networkManager = NetworkManager(logger: logger)
    }

    public func fetch(heights: [Int]) async throws -> [Int: String] {
        let parameters: Parameters = [
            "numbers": heights.map { String($0) }.joined(separator: ","),
        ]

        let blockResponses: [BlockResponse] = try await networkManager.fetch(
            url: "\(hsURL)/hashes",
            method: .get,
            parameters: parameters
        )
        var hashes = [Int: String]()

        for response in blockResponses {
            hashes[response.height] = response.hash
        }

        return hashes
    }
}

// MARK: - BlockResponse

struct BlockResponse: ImmutableMappable {
    let height: Int
    let hash: String

    init(map: Map) throws {
        height = try map.value("number")
        hash = try map.value("hash")
    }
}
