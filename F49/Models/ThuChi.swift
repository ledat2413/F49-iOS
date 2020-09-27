//
//  ThuChi.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ThuChi: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tenCuaHang: String = ""
    @objc dynamic var thu: String = ""
    @objc dynamic var chi: String = ""
    @objc dynamic var nguoiThucHien: String = ""
    @objc dynamic var colorBg: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenCuaHang <- map["tenCuaHang"]
        thu <- map["thu"]
        chi <- map["chi"]
        nguoiThucHien <- map["nguoiThucHien"]
        colorBg <- map["colorBg"]
        
    }
}
