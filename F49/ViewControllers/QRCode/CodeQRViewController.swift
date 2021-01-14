

import UIKit

class CodeQRViewController: BaseController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var qrCodeScanView: QRCodeScanView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Quét QR"
        // Do any additional setup after loading the view.
        qrCodeScanView.delegate = self
        

        // Stop camera when app moves to the background
        SwiftEventBus.onMainThread(self, name: UIApplication.didEnterBackgroundNotification.rawValue) { [weak self] (notification) in
            guard let wself = self else { return }
            wself.qrCodeScanView.stopRunning()
        }
        
        // Start camera when app become active from background
        SwiftEventBus.onMainThread(self, name: UIApplication.didBecomeActiveNotification.rawValue) { [weak self] (notification) in
            guard let wself = self else { return }
            wself.qrCodeScanView.startRunning()
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrCodeScanView.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        qrCodeScanView.stopRunning()
    }
    
    func handleQRCode(_ code: String) {
        debugPrint("code: \(code)")
        guard let jsonData = code.toJson(), let qrCode = QRCodeModel(representation: jsonData)  else {
            AlertView.show(message: "Dữ liệu không hợp lệ") { [weak self](button) in
                guard let wself = self else { return }
                wself.qrCodeScanView.startRunning()
            }
            return
        }
        print("ItemID", qrCode.ItemID)
        print("ListName", qrCode.ListName)
        print("Ma", qrCode.Ma)
        print("Title", qrCode.Title)
        print("WebUrl", qrCode.WebUrl)
    }
}


extension CodeQRViewController: QRCodeScanViewDelegate {
    func didFoundQRCode(_ code: String) {
        self.handleQRCode(code)
    }
}
