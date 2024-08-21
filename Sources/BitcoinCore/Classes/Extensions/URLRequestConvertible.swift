//
//  URLRequestConvertible+.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import Alamofire

extension URLRequestConvertible {
    
    var description: String {
        "\(urlRequest?.httpMethod ?? "") \(urlRequest?.url?.absoluteString ?? "")"
    }
}
