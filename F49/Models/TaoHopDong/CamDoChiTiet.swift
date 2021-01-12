//
//  CamDoChiTiet.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class CamDoChiTiet: Mappable{
    
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var balance: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var asset: String = ""
    @objc dynamic var brand: String = ""
    @objc dynamic var descriptionn: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var active: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        phone <- map["phone"]
        balance <- map["balance"]
        date <- map["date"]
        asset <- map["asset"]
        brand <- map["brand"]
        descriptionn <- map["description"]
        id <- map["id"]
        active <- map["active"]
    }
}
