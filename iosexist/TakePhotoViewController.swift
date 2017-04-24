//
//  TakePhotoViewController.swift
//  iosexist
//

import UIKit
import AVFoundation


class TakePhotoViewController: UIViewController {

    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var input: AVCaptureInput?
    
    var captureDevice : AVCaptureDevice?
    
    var btn: UIButton?
    var closeBtn: UIButton?
    var switchBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        beginSession()
    }

    func beginSession() {
        if captureSession.isRunning{
            captureSession.stopRunning()
        }
        if captureDevice == nil || captureDevice!.position == .front{
            captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        }else{
            if let devices = AVCaptureDevice.devices() as? [AVCaptureDevice] {
            // Loop through all the capture devices on this phone
                for device in devices {
                // Make sure this particular device supports video
                    if (device.hasMediaType(AVMediaTypeVideo)) {
                    // Finally check the position and confirm we've got the back camera
                        if(device.position == AVCaptureDevicePosition.front) {
                        captureDevice = device
                            if captureDevice != nil {
                                print("Capture device found")
                            }
                        }
                    }
                }
            }
        }
        
        do {
            print(captureDevice?.position.rawValue ?? "")
            
            if input != nil{
                captureSession.removeInput(input)
            }
            input = try AVCaptureDeviceInput(device: captureDevice)
            print(captureSession.canAddInput(input))
            
            if captureSession.canAddInput(input){
                captureSession.addInput(input)
            }
            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            
        }
        catch let error{
            print("error: \(error.localizedDescription)")
        }
        
        previewLayer?.removeFromSuperlayer()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
        
        closeBtn?.removeFromSuperview()
        closeBtn = UIButton()
        view.addSubview(closeBtn!)
        closeBtn?.setTitle("取消", for: .normal)
        closeBtn?.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        closeBtn?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 60, height: 50))
            make.left.equalToSuperview().offset(20)
        }

        switchBtn?.removeFromSuperview()
        switchBtn = UIButton()
        view.addSubview(switchBtn!)
        switchBtn?.setTitle("切换", for: .normal)
        switchBtn?.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)

        switchBtn?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 60, height: 50))
            make.right.equalToSuperview().offset(-20)
        }
        btn?.removeFromSuperview()
        btn = UIButton()
        view.addSubview(btn!)
        
        btn?.backgroundColor = UIColor.red
        btn?.layer.cornerRadius = 30
        btn?.layer.borderColor = UIColor.white.cgColor
        btn?.layer.borderWidth = 5
        
        btn?.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerX.equalToSuperview()
        }
        btn?.addTarget(self, action: #selector(saveToCamera), for: .touchUpInside)
    }
    func closeVC(){
        if captureSession.isRunning{
            captureSession.stopRunning()
        }

        dismiss(animated: true, completion: nil)
    }
    func switchCamera(){
        beginSession()

    }
    
    func saveToCamera() {
        
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (CMSampleBuffer, Error) in
                if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(CMSampleBuffer) {
                    
                    if let cameraImage = UIImage(data: imageData) {
                        
                        UIImageWriteToSavedPhotosAlbum(cameraImage, nil, nil, nil)
                    }
                }
                self.captureSession.stopRunning()

            })

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
