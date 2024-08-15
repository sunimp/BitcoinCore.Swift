import Foundation
import WWCryptoKit

public class DoubleShaHasher: IHasher {
    public init() {}

    public func hash(data: Data) -> Data {
        Crypto.doubleSha256(data)
    }
}
