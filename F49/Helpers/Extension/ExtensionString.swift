//
//  ExtensionString.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

extension String {
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        var st = self;
        if (self.count % 4 <= 2){
            st += String(repeating: "=", count: (self.count % 4))
        }
        guard let data = Data(base64Encoded: st) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
