//
//  TabTrangThai.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class TabTrangThai: Mappable{
    
    var id: Int = 0
    var tenTrangThai: String = ""
    
    required init?(map: Map) {
        
    }
    
    init(id: Int, tenTrangThai: String) {
        self.id = id
        self.tenTrangThai = tenTrangThai
    }

    func mapping(map: Map) {
        id <- map["id"]
        tenTrangThai <- map["tenTrangThai"]
    }
}
