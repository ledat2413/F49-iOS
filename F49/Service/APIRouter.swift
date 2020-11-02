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
    case GetListCamDo(trangThai: String)
    case GetChiTietCamDo(id: Int)
    case GetListDinhGia(trangThai: String)
    case GetChiTietDinhGia(id: Int)
    case GetListDoGiaDung(trangThai: String)
    case GetChiTietDoGiaDung(id: Int)
    case GetTab
    case GetListHopDongTheoLoai(params: [String: Any])
    case GetTrangThaiHopDong
    case GetChiTietHopDong(id: Int)
    case GetListThuChi(params: [String: Any])
    case GetDetailThuChiByID(id: Int)
    
    //Notification
    case GetListNotification(params: [String: Any])
    case PutReadAllNotification(idCuaHang: Int)
    
    
    case GetTabTrangThai
    case GetListRutLai(idShop: Int, idTab: Int )
    case GetDanhSachNhanVien
    case GetListVonDauTu(params: [String: Any])
    case GetDetailVonDauTu(id: Int)
    case GetListRutVon(idShop: Int, idTab: Int )
    case GetDetailRutVonByID(id: Int)
    case PutDuyetRutVon(params: [String: Any])
    case GetDLNhomTaiSan
    case GetDLTenTaiSan(id: Int)
    case GetTabTrangThaiTaiSan
    case GetDLTaiSan(idNhomVatCamDo: Int, idVatCamDo: Int, trangThai: Int)
    case GetDetailTaiSan(id: Int)
    case GetLichSuGiaoDich(id: Int)
    case GetCountLichSuGiaoDich(id: Int)
    case GetChiTietLichSuGiaoDich(idGiaoDich: Int, idHopDong: Int)
    case GetLichSuVayNo(id: Int)
    case GetCountLichSuVayNo(id: Int)
    case GetChiTietLichSuVayNo( idHopDong: Int)
    case GetBaoCaoTongHop(params: [String: Any])
    case GetTienHoaHong(params: [String: Any])
    case GetChiTietHopDongThuLai(idHopDong: Int, ngayHieuLuc: String)
    case GetLoaiGiaoDich
    case PutThucHienThuLai(idHopDong: Int,loaiGiaoDich: Int,idCuaHangFormApp: Int, tienThucTe: Double, ngayHieuLuc: String)
    case UploadImage(imgStr: String, soHopDong: String)
    case DanhSachTaiSanHDTC
    case ThuocTinhTaiSanHDTC(loaiTaiSan: String)
    case LoadTaoMoiHDTC(idCuaHang: Int)
//    case TinhSoTienKhachNhan(ngayVay: String, soTienVay: Double, laiXuat: Double, soNgayVay: Int, catLaiTruoc: Bool, tienPhuPhi: Double)
    case TinhSoTienKhachNhan(params: [String: Any])
    case LuuHopDongTheChap(params: [String: Any])
    case TimKiemKhachHang(key: String)

    //HopDongGiaDung
    case DanhSachTaiSanHDGD
    case LoadTaoMoiHDGD(idCuaHang: Int)
    case TinhTienLai(params: [String: Any])
    case TinhTienPhi(params: [String: Any])
    case LuuHopDongTraGop(params: [String: Any])
    
    
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
            
            //Notification
        case .GetListNotification:
            return "api/Notification/GetListNotification"
        case .PutReadAllNotification:
            return "api/Notification/PutReadAll"
            
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
        case .GetBaoCaoTongHop:
            return "api/BaoCao/GetBaoCaoTongHop"
        case .GetTienHoaHong:
            return "api/TienHoaHong/GetTienHoaHong"
        case .GetChiTietHopDongThuLai:
            return "api/ThuLai/GetChiTietHopDongThuLai"
        case .GetLoaiGiaoDich:
            return "api/ThuLai/GetLoaiGiaoDich"
        case .PutThucHienThuLai:
            return "api/ThuLai/PutThucHienThuLai"
        case .UploadImage:
            return "api/HopDong/UploadImage"
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
        case .TimKiemKhachHang:
            return "api/KhachHang/TimKiem"
        
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
        }
    }
    
    // MARK: - Headers
    public var headers: HTTPHeaders {
        var headers = ["Accept": "application/json", "Content-Type": "application/json"]
        //        var headers = ["Accept": "application/json"]
        
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
        case .PutReadAllNotification(let idCuaHang):
            return ["idCuaHang": idCuaHang]
            
            
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
            
        case .GetBaoCaoTongHop(let params):
            return params
            
        case .GetTienHoaHong(let params):
            return params
            
        case .GetChiTietHopDongThuLai(let idHopDong, let ngayHieuLuc):
            return ["idHopDong": idHopDong, "ngayHieuLuc": ngayHieuLuc]
            
        case .GetLoaiGiaoDich:
            return [:]
            
        case .PutThucHienThuLai(let idHopDong,let loaiGiaoDich,let idCuaHangFormApp,let tienThucTe,let ngayHieuLuc):
            return ["idHopDong" : idHopDong, "loaiGiaoDich": loaiGiaoDich , "idCuaHangFormApp": idCuaHangFormApp, "tienThuThucTe": tienThucTe, "ngayHieuLuc": ngayHieuLuc]
            
        case .UploadImage(let imgStr, let soHopDong):
            return ["imgStr" : imgStr, "soHopDong" : soHopDong]
            
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
            
        case .TimKiemKhachHang(let key):
            return ["key": key]
        
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

