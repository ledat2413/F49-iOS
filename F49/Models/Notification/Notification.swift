//
//  Notification.swift
//  F49
//
//  Created by Le Dat on 9/28/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Notificationn: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tieuDe: String = ""
    @objc dynamic var ngayGui: String = ""
    @objc dynamic var daDoc: Bool = false
    @objc dynamic var screenId: String = ""
    @objc dynamic var hinhAnh: String = ""
    @objc dynamic var idThongBao: Int = 0
    @objc dynamic var itemId: Int = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tieuDe <- map["tieuDe"]
        ngayGui <- map["ngayGui"]
        daDoc <- map["daDoc"]
        screenId <- map["screenId"]
        hinhAnh <- map["hinhAnh"]
        idThongBao <- map["idThongBao"]
        itemId <- map["itemId"]
    }
}

class CountNotify: Mappable{
    
    var countUnread: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        countUnread <- map["countUnread"]
    }
    
    
    
    
}
