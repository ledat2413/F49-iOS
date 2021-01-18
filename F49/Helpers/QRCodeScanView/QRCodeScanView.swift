//
//  QRCodeScanView.swift
//  OPLUS
//
//  Created by Van Le on 9/17/20.
//  Copyright © 2020 MyMind. All rights reserved.
//

import AVFoundation
import UIKit

protocol QRCodeScanViewDelegate: class {
    func didFoundQRCode(_ code: String)
}

class QRCodeScanView: BaseCustomView, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var didtabButton: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var focusView: UIView!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var flashLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var didTabButton2: UIButton!
    
    @IBOutlet weak var gradientImageView: UIImageView!
    
    weak var delegate: QRCodeScanViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        configCamera()
        self.flashButton.layer.cornerRadius = self.flashButton.frame.width / 2
        self.didtabButton.layer.cornerRadius = self.didtabButton.frame.width / 2
        self.didTabButton2.layer.cornerRadius = self.didTabButton2.frame.width / 2
        self.flashLabel.text = "BẬT FLASH"
        self.instructionLabel.text = "Đặt mã QR code ở trung tâm của hình vuông để quét tự động. "
  
    }
    
    @objc func scannerAnimation() {
        
        if !captureSession.isRunning { return }
        UIView.animate(withDuration: 2.5, animations: {
            self.gradientImageView.center.y += (self.cameraView.bounds.height + 300)
        }) { (_) in
            self.gradientImageView.center.y = -100
            self.scannerAnimation()
        }
    }
    
    deinit {
        stopRunning()
        NotificationCenter.default.removeObserver(self)
    }
    
    func configCamera() {
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        self.perform(#selector(scannerAnimation), with: nil, afterDelay: 0.3)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil) { [weak self] (noti) in
            guard let strongSelf = self else { return }
            let frame = strongSelf.focusView.frame
            metadataOutput.rectOfInterest = strongSelf.previewLayer.metadataOutputRectConverted(fromLayerRect: frame)
        }
    }
    
    func failed() {
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        delegate?.didFoundQRCode(code)
    }
    
    func startRunning() {
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
            self.scannerAnimation()
        }
    }
    
    func stopRunning() {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: Action
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if device.torchMode == AVCaptureDevice.TorchMode.on {
                    device.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device.setTorchModeOn(level: 1.0)
                    } catch let error {
                        print("error: \(error)")
                    }
                }
                device.unlockForConfiguration()
            } catch let error {
                print("error: \(error)")
            }
        }
    }
    
    @IBAction func didTapFlashButton(_ sender: UIButton) {
        flashButton.isSelected = !flashButton.isSelected
        flashLabel.text = flashButton.isSelected ? "TẮT FLASH" : "BẬT FLASH"
        toggleFlash()
    }
    
    @IBAction func didTapRefreshButton(_ sender: UIButton) {
        self.startRunning()
    }
    
}
