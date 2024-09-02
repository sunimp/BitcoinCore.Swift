//
//  String.swift
//
//  Created by Sun on 2018/7/18.
//

import Foundation

import WWExtensions

extension String {
    public var reversedData: Data? {
        ww.hexData.map { Data($0.reversed()) }
    }
}
