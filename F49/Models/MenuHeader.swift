//
//  Menu.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MenuHeader: Object, Mappable{
    
    @objc dynamic var camDo: Int = 0
    @objc dynamic var dinhGia: Int = 0
    @objc dynamic var doGiaDung: Int = 0
    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        camDo <- map["camDo"]
        dinhGia <- map["dinhGia"]
        doGiaDung <- map["doGiaDung"]
    }
}
