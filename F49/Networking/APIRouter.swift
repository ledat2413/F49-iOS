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
    
    //Login
    case Login(grant_type: String, username: String, password: String)
    
    //User Profile
    case GetUserProfile
    
    //DashBoard
    case GetCuaHang
    case GetDashBoard(id: Int)
    
    //HopDong
    case GetTab
    case GetTrangThaiHopDong
    case GetListHopDongTheoLoai(params: [String: Any])
    case GetChiTietHopDong(id: Int)
    case UploadImage(imgStr: String, soHopDong: String)

    //KhachHang
    case TimKiemKhachHang(key: String)

    //LichSu
    case GetLichSuGiaoDich(id: Int)
    case GetCountLichSuGiaoDich(id: Int)
    case GetChiTietLichSuGiaoDich(idGiaoDich: Int, idHopDong: Int)
    case GetLichSuVayNo(id: Int)
    case GetCountLichSuVayNo(id: Int)
    case GetChiTietLichSuVayNo( idHopDong: Int)
    
    //QuanLyTaiSan
    case GetDLNhomTaiSan
    case GetDLTenTaiSan(id: Int)
    case GetTabTrangThaiTaiSan
    case GetDLTaiSan(idNhomVatCamDo: Int, idVatCamDo: Int, trangThai: Int)
    case GetDetailTaiSan(id: Int)
    
    //QuanLyThuChi
    case GetListThuChi(params: [String: Any])
    case GetDetailThuChiByID(id: Int)
    
    //QuanLyVonDauTu
    case GetListVonDauTu(params: [String: Any])
    case GetDetailVonDauTu(id: Int)
    
    //RutLaiCuaHang
    case GetTabTrangThai
    case GetListRutLai(idShop: Int, idTab: Int )
    
    //RutVonCuaHang
    case GetListRutVon(idShop: Int, idTab: Int )
    case GetDetailRutVonByID(id: Int)
    case PutDuyetRutVon(params: [String: Any])
    
    //ThuLai
    case GetChiTietHopDongThuLai(idHopDong: Int, ngayHieuLuc: String)
    case GetLoaiGiaoDich
    case PutThucHienThuLai(idHopDong: Int,loaiGiaoDich: Int,idCuaHangFormApp: Int, tienThucTe: Double, ngayHieuLuc: String)
    
    //TienHoaHong
    case GetTienHoaHong(params: [String: Any])
    case GetDanhSachNhanVien

    //TienIch
    case GetTienIch(id: Int)
    
    //TopMenu
    case GetTopMenu
    case GetStatus
    case GetListCamDo(trangThai: String)
    case GetChiTietCamDo(id: Int)
    case GetListDinhGia(trangThai: String)
    case GetChiTietDinhGia(id: Int)
    case GetListDoGiaDung(trangThai: String)
    case GetChiTietDoGiaDung(id: Int)
    
    //Notification
    case GetListNotification(params: [String: Any])
    case GetCountNotify(idCuaHang: Int)
    case PutReadAllNotification(idCuaHang: Int)
    case PutStatusNotify(idNotify: Int)
    case DeleteNotification(id: Int)
   
    //BaoCao
    case GetBaoCaoTongHop(params: [String: Any])
    
    //HopDongTheChap
    case DanhSachTaiSanHDTC
    case ThuocTinhTaiSanHDTC(loaiTaiSan: String)
    case LoadTaoMoiHDTC(idCuaHang: Int)
    case TinhSoTienKhachNhan(params: [String: Any])
    case LuuHopDongTheChap(params: [String: Any])
    
    //HopDongGiaDung
    case DanhSachTaiSanHDGD
    case LoadTaoMoiHDGD(idCuaHang: Int)
    case TinhTienLai(params: [String: Any])
    case TinhTienPhi(params: [String: Any])
    case LuuHopDongTraGop(params: [String: Any])
    
    //HopDongGiaDungTraGop
    case LoadTaoMoiGDTG(idCuaHang: Int)
    case TinhSoTienKhachNhanGDTG(params: [String: Any])
    case TinhTienLaiHDTG(params: [String: Any])
    case TinhTienPhiHDTG(params: [String: Any])
    case LuuHopDongHDTG(params: [String: Any])
    
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        case .PutDuyetRutVon:
            return .put
        case .PutThucHienThuLai:
            return .put
        case .UploadImage:
            return .post
        case .LoadTaoMoiHDTC:
            return .post
        case .TinhSoTienKhachNhan:
            return .post
        case .LuuHopDongTheChap:
            return .post
        case .LoadTaoMoiHDGD:
            return .post
        case .TinhTienLai:
            return .post
        case .TinhTienPhi:
            return .post
        case .LuuHopDongTraGop:
            return .post
        case .PutReadAllNotification:
            return .put
        case .PutStatusNotify:
            return .put
        case .DeleteNotification:
            return .delete
        case .LoadTaoMoiGDTG:
            return .post
        case .TinhSoTienKhachNhanGDTG:
            return .post
        case .TinhTienPhiHDTG:
            return .post
        case .TinhTienLaiHDTG:
            return .post
        case .LuuHopDongHDTG:
            return .post
        default:
            return .get
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        
        //Login
        case .Login:
            return "token"
        
        //UserProfile
        case .GetUserProfile:
            return "api/UserProfile"
        
        //DashBoard
        case .GetCuaHang:
            return "api/Dashboard/GetCuaHang"
        case .GetDashBoard:
            return "api/Dashboard/GetDashboard"
        
        //TienIch
        case .GetTienIch:
            return "api/TienIch/GetTienIch"
        
        //TopMenu
        case .GetStatus:
            return "api/TopMenu/GetTrangThai"
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
        
        //HopDong
        case .GetTab:
            return "api/HopDong/GetTab"
        case .GetListHopDongTheoLoai:
            return "api/HopDong/GetListHopDongTheoLoai"
        case .GetTrangThaiHopDong:
            return "api/HopDong/GetTrangThaiHD"
        case .GetChiTietHopDong:
            return "api/HopDong/GetChiTietHopDong"
        case .UploadImage:
            return "api/HopDong/UploadImage"
            
        //ThuChi
        case .GetListThuChi:
            return "api/ThuChi/GetListThuChi"
        case .GetDetailThuChiByID:
            return "api/ThuChi/GetDetailThuChiByID"
            
        //Notification
        case .GetCountNotify:
            return "api/Notification/GetCountNotify"
        case .GetListNotification:
            return "api/Notification/GetListNotification"
        case .PutReadAllNotification:
            return "api/Notification/PutReadAll"
        case .PutStatusNotify:
            return "api/Notification/PutStatusNotify"
        case .DeleteNotification:
            return "api/Notification/DeleteNotify"
            
        //RutLai
        case .GetTabTrangThai:
            return "api/RutLai/GetTabTrangThai"
        case .GetListRutLai:
            return "api/RutLai/GetListRutLai"
        
        
        //QuanLyVon
        case .GetListVonDauTu:
            return "api/QuanLyVonDauTu/GetListVonDauTu"
        case .GetDetailVonDauTu:
            return "api/QuanLyVonDauTu/GetDetailVonDauTu"
    
        //RutVon
        case .GetListRutVon:
            return "api/RutVon/GetListRutVon"
        case .GetDetailRutVonByID:
            return "api/RutVon/GetDetailRutVonByID"
        case .PutDuyetRutVon:
            return "api/RutVon/PutDuyetRutVon"
        
        //QuanLyTaiSan
        case .GetDLNhomTaiSan:
            return "api/QuanLyTaiSan/GetDLNhomTS"
        case .GetDLTenTaiSan:
            return "api/QuanLyTaiSan/GetDLTenTaiSan"
        case .GetTabTrangThaiTaiSan:
            return "api/QuanLyTaiSan/GetTabTrangThaiTaiSan"
        case .GetDLTaiSan:
            return "api/QuanLyTaiSan/GetDSTaiSan"
        case .GetDetailTaiSan:
            return "api/QuanLyTaiSan/GetDetailTaiSan"
            
        //LichSu
        case .GetLichSuGiaoDich:
            return "api/LichSu/GetLichSuGiaoDich"
        case .GetCountLichSuGiaoDich:
            return "api/LichSu/GetCountLichSuGiaoDich"
        case .GetChiTietLichSuGiaoDich:
            return "api/LichSu/GetChiTietLichSuGiaoDich"
        case .GetLichSuVayNo:
            return "api/LichSu/GetLichSuVayNo"
        case .GetCountLichSuVayNo:
            return "api/LichSu/GetCountLichSuVayNo"
        case .GetChiTietLichSuVayNo:
            return "api/LichSu/GetChiTietLichSuVayNo"
        
        //BaoCao
        case .GetBaoCaoTongHop:
            return "api/BaoCao/GetBaoCaoTongHop"
        
        //TienHoaHong
        case .GetTienHoaHong:
            return "api/TienHoaHong/GetTienHoaHong"
        case .GetDanhSachNhanVien:
            return "api/TienHoaHong/GetDanhSachNhanVien"
            
        //ThuLai
        case .GetChiTietHopDongThuLai:
            return "api/ThuLai/GetChiTietHopDongThuLai"
        case .GetLoaiGiaoDich:
            return "api/ThuLai/GetLoaiGiaoDich"
        case .PutThucHienThuLai:
            return "api/ThuLai/PutThucHienThuLai"
        
        //HopDongTheChap
        case .DanhSachTaiSanHDTC:
            return "api/HopDongTheChap/LayDanhSachTaiSan"
        case .ThuocTinhTaiSanHDTC:
            return "api/HopDongTheChap/LayThuocTinhTaiSan"
        case .LoadTaoMoiHDTC:
            return "api/HopDongTheChap/LoadTaoMoi"
        case .TinhSoTienKhachNhan:
            return "api/HopDongTheChap/TinhSoTienKhachNhan"
        case .LuuHopDongTheChap:
            return "api/HopDongTheChap/LuuHopDong"
            
        //KhachHang
        case .TimKiemKhachHang:
            return "api/KhachHang/TimKiem"
            
        //Hop Dong Gia Dich
        case .DanhSachTaiSanHDGD:
            return "api/HopDongGDTG/LayDanhSachTaiSan"
        case .LoadTaoMoiHDGD:
            return "api/HopDongGDTG/LoadTaoMoi"
        case .TinhTienLai:
            return "api/HopDongGDTG/TinhTienLai"
        case .TinhTienPhi:
            return "api/HopDongGDTG/TinhTienPhi"
        case .LuuHopDongTraGop:
            return "api/HopDongTraGop/LuuHopDong"
            
        //Hop Dong Gia Dich Tra Gop
        case .LoadTaoMoiGDTG:
            return "api/HopDongGDTG/LoadTaoMoi"
        case .TinhSoTienKhachNhanGDTG:
            return "api/HopDongGDTG/TinhSoTienKhachNhan"
        case .TinhTienLaiHDTG:
            return "api/HopDongGDTG/TinhTienLai"
        case .TinhTienPhiHDTG:
            return "api/HopDongGDTG/TinhTienPhi"
        case .LuuHopDongHDTG:
            return "api/HopDongGDTG/LuuHopDong"
        }
    }
    
    // MARK: - Headers
    public var headers: HTTPHeaders {
        var headers = ["Accept": "application/json", "Content-Type": "application/json"]
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
        
        //Login
        case .Login(let grant_type, let username, let password):
            return ["grant_type": grant_type,
                    "username": username,
                    "password": password]
            
        //User Profile
        case .GetUserProfile:
            return [:]
            
        case .TimKiemKhachHang(let key):
            return ["key": key]
        case .GetCuaHang:
            return [:]
        
        //DashBoard
        case .GetDashBoard(let id):
            return ["idCuaHang": id]
        case .GetTienIch(let id):
            return ["idCuaHang": id]
            
        //Top Menu
        case .GetTopMenu:
            return [:]
        case .GetStatus:
            return [:]
        case .GetListCamDo(let trangThai):
            return ["trangThai": trangThai]
        case .GetListDinhGia(let trangThai):
            return ["trangThai": trangThai]
        case .GetListDoGiaDung(let trangThai):
            return ["trangThai": trangThai]
        case .GetChiTietCamDo(let id):
            return ["id": id]
        case .GetChiTietDinhGia(let id):
            return ["id": id]
        case .GetChiTietDoGiaDung(let id):
            return ["id": id]
            
        //Hop Dong
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
        case .UploadImage(let imgStr, let soHopDong):
            return ["imgStr" : imgStr, "soHopDong" : soHopDong]
            
        //Notification
        case .GetCountNotify(let idCuaHang):
            return ["idCuaHang": idCuaHang]
        case .GetListNotification(let params):
            return params
        case .PutReadAllNotification(let idCuaHang):
            return ["idCuaHang": idCuaHang]
        case .PutStatusNotify(let idNotify):
            return ["idNotify" : idNotify]
        case .DeleteNotification(let id):
            return ["id": id]
            
        //RutLai
        case .GetTabTrangThai:
            return [:]
        case .GetListRutLai(let idShop, let idTab):
            return ["idCuaHang": idShop , "idTab": idTab]
            
        //TienHoaHong
        case .GetDanhSachNhanVien:
            return [:]
        case .GetTienHoaHong(let params):
            return params
        
    
        //QuanLyVonDauTu
        case .GetListVonDauTu(let params):
            return params
        case .GetDetailVonDauTu(let id):
            return ["id" : id]
        
        //RutVon
        case .GetListRutVon(let idShop, let idTab):
            return ["idCuaHang": idShop , "idTab": idTab]
        case .GetDetailRutVonByID(let id):
            return ["idItem": id]
        case .PutDuyetRutVon(let params):
            return params
            
        //QuanLyTaiSan
        case .GetDLNhomTaiSan:
            return [:]
        case .GetDLTenTaiSan(let id):
            return ["idNhom" : id]
        case .GetTabTrangThaiTaiSan:
            return [:]
        case .GetDLTaiSan(let idNhomVatCamDo, let idVatCamDo, let trangThai):
            return ["idNhomVatCamDo": idNhomVatCamDo, "idVatCamDo" : idVatCamDo, "trangThai" : trangThai]
        case .GetDetailTaiSan(let id):
            return ["idItem" : id]
        
        //LichSu
        case .GetLichSuGiaoDich(let id):
            return ["idHopDong" : id]
        case .GetCountLichSuGiaoDich(let id):
            return ["idHopDong" : id]
        case .GetChiTietLichSuGiaoDich(let idGiaoDich, let idHopDong):
            return ["idGiaoDich": idGiaoDich, "idHopDong": idHopDong]
        case .GetLichSuVayNo(let id):
            return ["idKhachHang" : id]
        case .GetChiTietLichSuVayNo(let idHopDong):
            return ["idHopDong" : idHopDong]
        case .GetCountLichSuVayNo(let id):
            return ["idKhachHang" : id]
        
        //BaoCaoTongHop
        case .GetBaoCaoTongHop(let params):
            return params
        
        //ThuLai
        case .GetChiTietHopDongThuLai(let idHopDong, let ngayHieuLuc):
            return ["idHopDong": idHopDong, "ngayHieuLuc": ngayHieuLuc]
        case .GetLoaiGiaoDich:
            return [:]
        case .PutThucHienThuLai(let idHopDong,let loaiGiaoDich,let idCuaHangFormApp,let tienThucTe,let ngayHieuLuc):
            return ["idHopDong" : idHopDong, "loaiGiaoDich": loaiGiaoDich , "idCuaHangFormApp": idCuaHangFormApp, "tienThuThucTe": tienThucTe, "ngayHieuLuc": ngayHieuLuc]            
       
        //HopDongTheChap
        case .DanhSachTaiSanHDTC:
            return [:]
        case .ThuocTinhTaiSanHDTC(let loaiTaiSan):
            return ["loaiTaiSan": loaiTaiSan]
        case .LoadTaoMoiHDTC(let idCuaHang):
            return ["IDCuaHang": idCuaHang]
        case .TinhSoTienKhachNhan(let params):
            return params
        case .LuuHopDongTheChap(let params):
            return params
            
        //HopDongGiaDung
        case .DanhSachTaiSanHDGD:
            return [:]
        case .LoadTaoMoiHDGD(let idCuaHang):
            return ["idCuaHang" : idCuaHang]
        case .TinhTienLai(let params):
            return params
        case .TinhTienPhi(let params):
            return params
        case .LuuHopDongTraGop(let params):
            return params
            
        //HopDongGiaDungTraGop
        case .LoadTaoMoiGDTG(let idCuaHang):
            return ["idCuaHang": idCuaHang]
        case .TinhSoTienKhachNhanGDTG(let params):
            return params
        case .TinhTienLaiHDTG( let params):
            return params
        case .TinhTienPhiHDTG( let params):
            return params
        case .LuuHopDongHDTG( let params):
            return params
        }
    }
    
    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        let url = try Production.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        switch method {
        case .post:
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case .Login:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                
            default:
                
                if let parameters = parameters {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                }
            }
            
        default:
            
            if let parameters = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
            urlRequest.httpMethod = method.rawValue
        }
        return urlRequest
    }
    
    static func printResponse(request: URLRequest?, data: Data ) {
        print("===================================================")
        print("api: \(String(describing: request?.url))")
        print("header: \(String(describing: request?.allHTTPHeaderFields))")
        if let data = request?.httpBody {
            print("param: \(String(decoding: data, as: UTF8.self))")
        }
        
        if let dataJson = String(data: data, encoding: .utf8), let jsonString = dataJson.data(using: .utf8)?.prettyPrintedJSONString {
            print("value: \(jsonString)")
        }
        
    }
    
    
}

