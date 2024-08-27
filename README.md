# BitcoinCore.Swift

`BitcoinCore.Swift` is a core package that implements a full Simplified Payment Verification (`SPV`) client in `Swift`. It implements Bitcoin `P2P Protocol` and can be extended to be a client of other Bitcoin forks like BitcoinCash, Litecoin, etc. Currently, we have extensions [BitcoinKit.Swift](https://github.com/sunimp/BitcoinKit.Swift), [BitcoinCashKit.Swift](https://github.com/sunimp/BitcoinCashKit.Swift), [LitecoinKit.Swift](https://github.com/sunimp/LitecoinKit.Swift) and [DashKit.Swift](https://github.com/sunimp/DashKit.Swift) that complement this package with blockchain(fork) specific logic.

Being an SPV client, `BitcoinCore.Swift` downloads and validates all the block headers, inclusion of transactions in the blocks, integrity and immutability of transactions as described in the Bitcoin whitepaper or delegates validation to the extensions that implement the forks of Bitcoin.  

## Features

- [x] Bitcoin P2P Protocol implementaion in Swift.
- [x] Full SPV implementation for fast mobile performance with account security and privacy in mind
- [x] `P2PK`, `P2PKH`, `P2SH-P2WPKH`, `P2WPKH` outputs support.
- [x] Restoring with mnemonic seed. (Generated from private seed phrase)
- [x] Restoring with [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) extended public key. (This becomes a `Watch account` unable to spend funds)
- [x] Quick initial restore over node API. (optional)
- [x] Handling transaction (Replacement)/(Doube spend)/(Failure by expiration)
- [x] Optimized UTXO selection when spending coins.
- [x] [BIP69](https://github.com/bitcoin/bips/blob/master/bip-0069.mediawiki) or simple shuffle output ordering. (configurable)
- [x] [BIP21](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki) URI schemes with payment address, amount, label and other parameters


## Usage

This package is designed to be used by a concrete kit like BitcoinKit.Swift. See [BitcoinKit.Swift](https://github.com/sunimp/BitcoinKit.Swift) for more documentation.

## Prerequisites

* Xcode 15.0+
* Swift 5.10+
* iOS 14+

### Swift Package Manager

[Swift Package Manager](https://www.swift.org/package-manager/) is a dependency manager for Swift projects. You can install `BitcoinCore.Swift` by adding a line in `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/sunimp/BitcoinCore.Swift.git", .upToNextMajor(from: "3.1.1"))
]
```

## License

The `BitcoinCore.Swift` toolkit is open source and available under the terms of the [MIT License](https://github.com/sunimp/BitcoinCore.Swift/blob/master/LICENSE).

