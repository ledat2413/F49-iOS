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
    case GetDanhSachNhanVien
    case GetListVonDauTu(params: [String: Any])
    case GetDetailVonDauTu(id: Int)
    case GetListRutVon(idShop: Int, idTab: Int )
    case GetDetailRutVonByID(id: Int)
    case PutDuyetRutVon(params: [String: Any])
    
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        case .PutDuyetRutVon:
            return .put
        default:
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
        case .GetDanhSachNhanVien:
            return "api/TienHoaHong/GetDanhSachNhanVien"
        case .GetListVonDauTu:
            return "api/QuanLyVonDauTu/GetListVonDauTu"
        case .GetDetailVonDauTu:
            return "api/QuanLyVonDauTu/GetDetailVonDauTu"
        case .GetListRutVon:
            return "api/RutVon/GetListRutVon"
        case .GetDetailRutVonByID:
            return "api/RutVon/GetDetailRutVonByID"
        case .PutDuyetRutVon:
            return "api/RutVon/PutDuyetRutVon"
        }
    }
    
    // MARK: - Headers
    public var headers: HTTPHeaders {
        var headers = [ "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
        
        switch self {
        case .Login:
            break
        default:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                headers["Authorization"] = token
            }
            break
        }
        
        return headers;
    }
    
    // MARK: - Parameters
    public var parameters: Parameters? {
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
        case .GetDanhSachNhanVien:
            return [:]
        case .GetListVonDauTu(let params):
            return params
        case .GetDetailVonDauTu(let id):
            return ["id" : id]
        case .GetListRutVon(let idShop, let idTab):
            return ["idCuaHang": idShop , "idTab": idTab]
        case .GetDetailRutVonByID(let id):
            return ["idItem": id]
        case .PutDuyetRutVon(let params):
            return params
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
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        }
        return urlRequest
    }
    
}

