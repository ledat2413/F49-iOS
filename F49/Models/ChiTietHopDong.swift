//
//  ChiTietHopDong.swift
//  F49
//
//  Created by Le Dat on 9/24/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ChiTietHopDong: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var numberContract: String = ""
    @objc dynamic var idKhachHang: Int = 0
    @objc dynamic var fullName: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var duNo: String = ""
    @objc dynamic var expiredDate: String = ""
    @objc dynamic var plusMin: Int = 0
    @objc dynamic var interest: String = ""
    @objc dynamic var fee: String = ""
    @objc dynamic var total: String = ""
    @objc dynamic var appointmentDate: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var doDeLai: String = ""
    @objc dynamic var catLai: Bool = false
    @objc dynamic var ngayNhacNho: String = ""
    @objc dynamic var countLichSuGiaoDich: Int = 0
    @objc dynamic var countLichSuVay: Int = 0
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        idKhachHang <- map["idKhachHang"]
        numberContract <- map["numberContract"]
        fullName <- map["fullName"]
        phoneNumber <- map["phoneNumber"]
        duNo <- map["duNo"]
        expiredDate <- map["expiredDate"]
        plusMin <- map["plusMin"]
        interest <- map["interest"]
        fee <- map["fee"]
        total <- map["total"]
        appointmentDate <- map["appointmentDate"]
        content <- map["content"]
        doDeLai <- map["doDeLai"]
        catLai <- map["catLai"]
        ngayNhacNho <- map["ngayNhacNho"]
        countLichSuGiaoDich <- map["countLichSuGiaoDich"]
        countLichSuVay <- map["countLichSuVay"]
        
    }
}

class HinhAnh: Object, Mappable{
    @objc dynamic var url: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var extensions: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        name <- map["name"]
        extensions <- map["extension"]
    }
    
    
}
