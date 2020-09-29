//
//  TabTrangThai.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TabTrangThai: Mappable{
    required init?(map: Map) {
        
    }
    
    
    var id: Int = 0
    var tenTrangThai: String = ""
    
    
    init(id: Int, tenTrangThai: String) {
        self.id = id
        self.tenTrangThai = tenTrangThai
    }
    
    //    required convenience init?(map: Map) {
    //        self.init()
    //    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        tenTrangThai <- map["tenTrangThai"]
    }
    
}
