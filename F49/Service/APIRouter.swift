//
//  APIRouter.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    // =========== Begin define api ===========
    case Login(grant_type: String, username: String, password: String)
    case GetUserProfile
    case GetCuaHang
    case GetDashBoard(id: Int)
    case GetTienIch(id: Int)
    case GetTopMenu
    case GetStatus
    case GetListCamDo(id: String)
    case GetChiTietCamDo(id: Int)
    case GetListDinhGia(id: String)
    case GetChiTietDinhGia(id: Int)
    case GetListDoGiaDung(id: String)
    case GetChiTietDoGiaDung(id: Int)
    case GetTab
    case GetListHopDongTheoLoai(params: [String: Any])
    case GetTrangThaiHopDong
    case GetChiTietHopDong(id: Int)
    case GetListThuChi(params: [String: Any])
    case GetDetailThuChiByID(id: Int)
    case GetListNotification(params: [String: Any])
    case GetTabTrangThai
    case GetListRutLai(idShop: Int, idTab: Int )
    
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        case .GetUserProfile:
            return .get
        case .GetCuaHang:
            return .get
        case .GetDashBoard:
            return .get
        case .GetStatus:
            return .get
        case .GetTienIch:
            return .get
        case .GetListCamDo:
            return .get
        case .GetChiTietCamDo:
            return .get
        case .GetTopMenu:
            return .get
        case .GetListDinhGia:
            return .get
        case .GetListDoGiaDung:
            return .get
        case .GetChiTietDinhGia:
            return .get
        case .GetChiTietDoGiaDung:
            return .get
        case .GetTab:
            return .get
        case .GetListHopDongTheoLoai:
            return .get
        case .GetTrangThaiHopDong:
            return .get
        case .GetChiTietHopDong:
            return .get
        case .GetListThuChi:
            return .get
        case .GetDetailThuChiByID:
            return .get
        case .GetListNotification:
            return .get
        case .GetTabTrangThai:
            return .get
        case .GetListRutLai:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .Login:
            return "token"
        case .GetUserProfile:
            return "api/UserProfile"
        case .GetCuaHang:
            return "api/Dashboard/GetCuaHang"
        case .GetDashBoard:
            return "api/Dashboard/GetDashboard"
        case .GetStatus:
            return "api/TopMenu/GetTrangThai"
        case .GetTienIch:
            return "api/TienIch/GetTienIch"
        case .GetTopMenu:
            return "api/TopMenu"
        case .GetListCamDo:
            return "api/TopMenu/GetListCamDo"
        case .GetChiTietCamDo:
            return "api/TopMenu/GetChiTietCamDo"
        case .GetListDinhGia:
            return "api/TopMenu/GetListDinhGia"
        case .GetChiTietDinhGia:
            return "api/TopMenu/GetChiTietDinhGia"
        case .GetListDoGiaDung:
            return "api/TopMenu/GetListDoGiaDung"
        case .GetChiTietDoGiaDung:
            return "api/TopMenu/GetChiTietDoGiaDung"
        case .GetTab:
            return "api/HopDong/GetTab"
        case .GetListHopDongTheoLoai:
            return "api/HopDong/GetListHopDongTheoLoai"
        case .GetTrangThaiHopDong:
            return "api/HopDong/GetTrangThaiHD"
        case .GetChiTietHopDong:
            return "api/HopDong/GetChiTietHopDong"
        case .GetListThuChi:
            return "api/ThuChi/GetListThuChi"
        case .GetDetailThuChiByID:
            return "api/ThuChi/GetDetailThuChiByID"
        case .GetListNotification:
            return "api/Notification/GetListNotification"
        case .GetTabTrangThai:
            return "api/RutLai/GetTabTrangThai"
        case .GetListRutLai:
            return "api/RutLai/GetListRutLai"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers = ["Accept": "application/json"]
        switch self {
        case .Login:
            break
        case .GetUserProfile:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetCuaHang:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
            
        case .GetDashBoard:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetTienIch:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetStatus:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListCamDo:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetChiTietCamDo:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetTopMenu:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListDinhGia:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListDoGiaDung:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetChiTietDinhGia:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetChiTietDoGiaDung:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetTab:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListHopDongTheoLoai:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetTrangThaiHopDong:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetChiTietHopDong:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListThuChi:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetDetailThuChiByID:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListNotification:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetTabTrangThai:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        case .GetListRutLai:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        }
        
        return headers;
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .Login(let grant_type, let username, let password):
            return ["grant_type": grant_type,
                    "username": username,
                    "password": password]
            
        case .GetUserProfile:
            return [:]
            
        case .GetCuaHang:
            return [:]
            
        case .GetDashBoard(let id):
            return ["idCuaHang": id]
            
        case .GetTienIch(let id):
            return ["idCuaHang": id]
            
        case .GetTopMenu:
            return [:]
            
        case .GetStatus:
            return [:]
            
        case .GetListCamDo(let id):
            return ["trangThai": id]
            
        case .GetListDinhGia(let id):
            return ["trangThai": id]
            
        case .GetListDoGiaDung(let id):
            return ["trangThai": id]
            
        case .GetChiTietCamDo(let id):
            return ["id": id]
            
        case .GetChiTietDinhGia(let id):
            return ["id": id]
            
        case .GetChiTietDoGiaDung(let id):
            return ["id": id]
        case .GetTab:
            return [:]
        case .GetListHopDongTheoLoai(let params):
            return params
        case .GetTrangThaiHopDong:
            return [:]
        case .GetChiTietHopDong(let id):
            return ["idHopDong": id]
        case .GetListThuChi(let params):
            return params
        case .GetDetailThuChiByID(let id):
            return ["idItem": id]
        case .GetListNotification(let params):
            return params
        case .GetTabTrangThai:
            return [:]
        case .GetListRutLai(let idShop, let idTab):
            return ["idCuaHang": idShop , "idTab": idTab]
        }
    }
    
    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        let url = try Production.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        return urlRequest
    }
    
}

