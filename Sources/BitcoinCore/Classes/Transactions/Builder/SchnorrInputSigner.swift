//
//  SchnorrInputSigner.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import HDWalletKit
import WWCryptoKit
import WWExtensions

// MARK: - SchnorrInputSigner

class SchnorrInputSigner {
    enum SignError: Error {
        case noPreviousOutput
        case noPreviousOutputAddress
        case noPrivateKey
    }

    let hdWallet: IPrivateHDWallet

    init(hdWallet: IPrivateHDWallet) {
        self.hdWallet = hdWallet
    }
}

// MARK: IInputSigner

extension SchnorrInputSigner: IInputSigner {
    func sigScriptData(transaction: Transaction, inputsToSign: [InputToSign], outputs: [Output], index: Int) throws -> [Data] {
        let input = inputsToSign[index]
        let pubKey = input.previousOutputPublicKey

        guard
            let privateKeyData = try? hdWallet.privateKeyData(
                account: pubKey.account,
                index: pubKey.index,
                external: pubKey.external
            )
        else {
            throw SignError.noPrivateKey
        }

        let serializedTransaction = try TransactionSerializer.serializedForTaprootSignature(
            transaction: transaction,
            inputsToSign: inputsToSign,
            outputs: outputs,
            inputIndex: index
        )

        let signatureHash = try SchnorrHelper.hashTweak(data: serializedTransaction, tag: "TapSighash")
        let signature = try SchnorrHelper.sign(data: signatureHash, privateKey: privateKeyData, publicKey: pubKey.raw)

        return [signature]
    }
}
