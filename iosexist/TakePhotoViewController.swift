//
//  TakePhotoViewController.swift
//  iosexist
//

import UIKit
import AVFoundation
import Photos

class TakePhotoViewController: UIViewController {

    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var input: AVCaptureInput?
    
    var captureDevice : AVCaptureDevice?
    
    var btn: UIButton?
    var closeBtn: UIButton?
    var switchBtn: UIButton?
    var finishBtn:UIButton?
    var openAlum:UIButton?
    var captureDeviceMode: UIButton?
    var mode = 0
    
    var photoListView: UICollectionView?
    
    var images = [UIImage]()
    var selectedImages = [Int]()
    
    let collectionViewHeight:CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        beginSession()
        
        photoShow()
    }
    func photoShow(){
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width  / 5

        layout.itemSize = CGSize(width: width, height: collectionViewHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        
        photoListView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        photoListView?.isScrollEnabled = false
        photoListView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "collectcell")
        
        photoListView?.dataSource = self
        photoListView?.delegate = self
        
        view.addSubview(photoListView!)
        photoListView?.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.collectionViewHeight)
        }
        photoListView?.backgroundColor = UIColor.black
        
        
        fetchPhotoAtIndexFromEnd(0)
        
    }
    internal func finishAction(){
        if captureSession.isRunning{
            captureSession.stopRunning()
        }

        dismiss(animated: true, completion: nil)
    }
    func completeImages(){
        photoListView?.reloadData()
    }
    func fetchPhotoAtIndexFromEnd(_ index: Int){
        
        let width = UIScreen.main.bounds.width / 5
        let size = CGSize(width: width, height: collectionViewHeight)
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        if fetchResult.count > 0 {
            PHImageManager.default().requestImage(for: fetchResult.object(at: fetchResult.count - 1 - index) as PHAsset, targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, data) in
                
                self.images.append(image!)
                
                if index + 1 < fetchResult.count && self.images.count < 5 {
                    self.fetchPhotoAtIndexFromEnd(index + 1)
                } else {
                    // Else you have completed creating your array
                    self.completeImages()
                }
                
            })
        }
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
        
        var frame = self.view.layer.frame
        frame.origin.y = collectionViewHeight
        frame.size.height -= collectionViewHeight
        frame.size.width = view.frame.width
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill

        previewLayer?.frame = frame
        
        self.view.layer.addSublayer(previewLayer!)
        
    
        captureSession.startRunning()
        
    

        switchBtn?.removeFromSuperview()
        switchBtn = UIButton()
        view.addSubview(switchBtn!)
        switchBtn?.setTitle("切换", for: .normal)
        switchBtn?.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)

        switchBtn?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15 + self.collectionViewHeight)
            make.size.equalTo(CGSize(width: 60, height: 50))
            make.right.equalToSuperview().offset(-10)
        }
        
        captureDeviceMode?.removeFromSuperview()

        if captureDevice?.position == .back{
            captureDeviceMode = UIButton()
            view.addSubview(captureDeviceMode!)
            captureDeviceMode?.snp.makeConstraints({ (make) in
                make.centerY.equalTo(switchBtn!.snp.centerY)
                make.right.equalTo(switchBtn!.snp.left).offset(-8)
                make.size.equalTo(CGSize(width: 24, height: 24))
            })
            captureDeviceMode?.clipsToBounds = true
            captureDeviceMode?.setImage(#imageLiteral(resourceName: "flash"), for: .normal)
            captureDeviceMode?.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
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
        
        finishBtn?.removeFromSuperview()
        finishBtn = UIButton()
        view.addSubview(finishBtn!)
        finishBtn?.setTitle("完成", for: .normal)
        finishBtn?.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
        finishBtn?.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 50))
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(btn!.snp.centerY)
        }
        
        closeBtn?.removeFromSuperview()
        closeBtn = UIButton()
        view.addSubview(closeBtn!)
        closeBtn?.setTitle("取消", for: .normal)
        closeBtn?.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        closeBtn?.snp.makeConstraints { (make) in
            make.centerY.equalTo(btn!.snp.centerY)
            make.size.equalTo(CGSize(width: 60, height: 50))
            make.left.equalToSuperview().offset(10)
        }
        openAlum?.removeFromSuperview()
        openAlum = UIButton()
        view.addSubview(openAlum!)
        openAlum?.snp.makeConstraints { (make) in
            make.centerY.equalTo(btn!.snp.centerY)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(self.closeBtn!.snp.right).offset(10)
        }
        openAlum?.setImage(#imageLiteral(resourceName: "roll-Icon"), for: .normal)
        
    }
    func changeMode(){
        do{
            try captureDevice!.lockForConfiguration()
            //let torchOn = captureDevice!.isTorchActive
            mode += 1
            if self.mode > 2{
                self.mode = 0
            }
            captureDevice!.torchMode = AVCaptureTorchMode(rawValue: self.mode)!
            if self.mode == 1{
                try captureDevice!.setTorchModeOnWithLevel(1.0)
            }
            captureDevice!.unlockForConfiguration()
        }catch{
            
        }
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
                        
                        self.images.removeAll()
                        self.images.append(cameraImage)
                        self.selectedImages.removeAll()
                        self.completeImages()
                        
                      //  UIImageWriteToSavedPhotosAlbum(cameraImage, nil, nil, nil)
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
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

extension TakePhotoViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedImages.contains(indexPath.item){
            let atindex = selectedImages
            .index(of: indexPath.item)
            selectedImages.remove(at: atindex!)
        }else{
            selectedImages.append(indexPath.item)
        }
        collectionView.reloadData()
    }
}
extension TakePhotoViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectcell", for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = images[indexPath.item]
        if selectedImages.contains(indexPath.item){
           cell.selectBtn.isSelected = true
        }
        else{
            cell.selectBtn.isSelected = false
        }
        return cell
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
