//
//  Extend.swift
//  F49
//
//  Created by Le Dat on 10/21/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation


class ALAMOFIRE {
    fileprivate static func printResponse(request: URLRequest?, data: Data ) {
        print("===================================================")
        print("api: \(String(describing: request?.url))")
        print("header: \(String(describing: request?.allHTTPHeaderFields))")
        if let data = request?.httpBody {
            print("param: \(String(decoding: data, as: UTF8.self))")
        }
        
        if let dataJson = String(data: data, encoding: .utf8), let jsonString = dataJson.data(using: .utf8)?.prettyPrintedJSONString {
            print("value: \(jsonString)")
        }
        
    }
}

