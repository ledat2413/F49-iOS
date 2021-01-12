//
//  DoGiaDung.swift
//  F49
//
//  Created by Le Dat on 9/19/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//


import Foundation
import ObjectMapper


class DoGiaDung: Mappable{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var active: Bool = false
    @objc dynamic var date: String = ""
    @objc dynamic var asset: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        active <- map["active"]
        date <- map["date"]
        asset <- map["asset"]
        
    }
}

class DoGiaDungChiTiet: Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var active: Bool = false
    @objc dynamic var date: String = ""
    @objc dynamic var asset: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        active <- map["active"]
        date <- map["date"]
        asset <- map["asset"]
        
    }
}
