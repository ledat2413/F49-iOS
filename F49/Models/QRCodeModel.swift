 import Foundation

 struct QRCodeModel: ResponseObjectSerializable {
     var Title: String = ""
     var ListName: String = ""
     var ItemID: Int = 0
     var WebUrl: String = ""
     var Ma: String = ""
     
     init() {
     }
     
     init?(representation: Any) {
         guard let json = representation as? [String: Any] else { return nil }
         self.Title = json["Title"] as? String ?? ""
         self.ListName = json["ListName"] as? String ?? ""
         self.ItemID = json["ItemID"] as? Int ?? 0
         self.WebUrl = json["WebUrl"] as? String ?? ""
         self.Ma = json["Ma"] as? String ?? ""
     }
     
 }
