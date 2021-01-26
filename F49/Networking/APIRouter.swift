//
//  APIRouter.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    // =========== Begin define api ===========
    
    //Login
    case Login(grant_type: String, username: String, password: String)
    
    //Firebase
    case PutFirebase(email: String, token: String, deviceName: String, flg: Bool)
    
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
    case KhachHangLuu(hoTen: String, soCMND: String,dienThoai: String, queQuan: String)
    
    //LichSu
    case GetLichSuGiaoDich(id: Int)
    case GetCountLichSuGiaoDich(id: Int)
    case GetChiTietLichSuGiaoDich(idGiaoDich: Int, idHopDong: Int)
    case GetLichSuVayNo(id: Int)
    case GetCountLichSuVayNo(idKhachHang: Int)
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
    
    
    // MARK: - URL request
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Common Headers
        switch self {
        case .Login:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            break
        default:
            if let token = UserHelper.getUserData(key: UserKey.Token){
                urlRequest.setValue(token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            break
        }
        
        // HTTP Method
        switch method {
        case .post:
           
            urlRequest.httpMethod = method.rawValue
            if let params = parameters {
                switch self {
                case .Login:
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
                default:
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
                }
            }
            
        default:
            if let params = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
                
                urlRequest.httpMethod = method.rawValue
            }
            
        }
        return urlRequest
    }
    
    static func printResponse(request: URLRequest?, data: Data ) {
        print("===================================================")
        print("api: \(String(describing: request?.url))")
        print("header: \(String(describing: request?.allHTTPHeaderFields))")
        print("method: \(String(describing: request?.httpMethod))")
        if let data = request?.httpBody {
            print("param: \(String(decoding: data, as: UTF8.self))")
        }
        
        if let dataJson = String(data: data, encoding: .utf8), let jsonString = dataJson.data(using: .utf8)?.prettyPrintedJSONString {
            print("value: \(jsonString)")
        }
        
    }
   
}
