//
//  DinhGia.swift
//  F49
//
//  Created by Le Dat on 9/19/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class DinhGia: Object, Mappable{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var active: Bool = false
    @objc dynamic var image: String = ""
    @objc dynamic var regDate: String = ""
    @objc dynamic var orders: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        active <- map["active"]
        image <- map["image"]
        regDate <- map["regDate"]
        orders <- map["orders"]
        
    }
}

class DinhGiaChiTiet: Object, Mappable{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var active: Bool = false
    @objc dynamic var image: String = ""
    @objc dynamic var regDate: String = ""
    @objc dynamic var orders: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        active <- map["active"]
        image <- map["image"]
        regDate <- map["regDate"]
        orders <- map["orders"]
        
    }
}
