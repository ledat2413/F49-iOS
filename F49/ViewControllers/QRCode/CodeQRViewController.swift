

import UIKit

class CodeQRViewController: BaseController {

    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var qrCodeScanView: QRCodeScanView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        navigation.titleLabel.text = "Quét QR"
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
    
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension CodeQRViewController: QRCodeScanViewDelegate {
    func didFoundQRCode(_ code: String) {
        self.handleQRCode(code)
    }
}
