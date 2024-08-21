//
//  String+.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import WWExtensions

extension String {
    
    public var reversedData: Data? {
        self.ww.hexData.map { Data($0.reversed()) }
    }
}
