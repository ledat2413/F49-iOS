//
//  TienIch.swift
//  F49
//
//  Created by Le Dat on 9/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//
import Foundation
import ObjectMapper
import RealmSwift

class TienIch: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tieuDe: String = ""
    @objc dynamic var giaTri: String = ""
    @objc dynamic var hinhAnh: String = ""
    @objc dynamic var screenId: String = ""
    @objc dynamic var sapXep: Int = 0
    @objc dynamic var mauSac: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
         id <- map["id"]
        tieuDe <- map["tieuDe"]
        giaTri <- map["giaTri"]
        hinhAnh <- map["hinhAnh"]
        screenId <- map["screenId"]
        sapXep <- map["sapXep"]
        mauSac <- map["mauSac"]
    }
    
}
