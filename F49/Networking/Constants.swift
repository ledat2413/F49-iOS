//
//  Constants.swift
//  F49
//
//  Created by Le Dat on 11/13/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//


import Foundation
import Alamofire

struct Constants {
    struct ProductionServer {
        static var baseURL: String = Bundle.main.object(forInfoDictionaryKey: "ServerApi") as! String
    }

    struct APIParameterKey {
        static let grant_type = "grant_type"
        static let username = "username"
        static let password = "password"
        static let key = "key"
        static let idCuaHang = "idCuaHang"
        static let trangThai = "trangThai"
        static let id = "id"
        static let idHopDong = "idHopDong"
        static let idKhachHang = "idKhachHang"
        static let idItem = "idItem"
        static let imgStr = "imgStr"
        static let soHopDong = "soHopDong"
        static let idNotify = "idNotify"
        static let idTab = "idTab"
        static let idNhom = "idNhom"
        static let idNhomVatCamDo = "idNhomVatCamDo"
        static let idVatCamDo = "idVatCamDo"
        static let idGiaoDich = "idGiaoDich"
        static let ngayHieuLuc = "ngayHieuLuc"
        static let loaiGiaoDich = "loaiGiaoDich"
        static let idCuaHangFormApp = "idCuaHangFormApp"
        static let tienThuThucTe = "tienThuThucTe"
        static let loaiTaiSan = "loaiTaiSan"
        static let IDCuaHang = "IDCuaHang"
        static let token = "token"
        static let email = "email"
        static let deviceName = "deviceName"
        static let flg = "flg"
        
    }
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    
}

enum ContentType: String {
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
    case EMAIL_ISVALID
    case PASS_ISVALID
}
