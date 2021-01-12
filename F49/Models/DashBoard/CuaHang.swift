//
//  CuaHang.swift
//  F49
//
//  Created by Le Dat on 9/14/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

import ObjectMapper

class CuaHang: Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var tenCuaHang: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenCuaHang <- map["tenCuaHang"]
    }
    
}
