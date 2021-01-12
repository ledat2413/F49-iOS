//
//  Notification.swift
//  F49
//
//  Created by Le Dat on 9/28/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class Notificationn: Mappable{
    
    var id: Int = 0
    var tieuDe: String = ""
    var ngayGui: String = ""
    var daDoc: Bool = false
    var screenId: String = ""
    var hinhAnh: String = ""
    var idThongBao: Int = 0
    var itemId: Int = 0
    
    required init?(map: Map) {
        mapping(map: map)
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
