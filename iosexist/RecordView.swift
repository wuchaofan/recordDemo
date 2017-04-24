//
//  RecordView.swift
//  iosexist
//


import UIKit
import AVFoundation


class RecordView: UIView , AVAudioRecorderDelegate{

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var timer: Timer!
    let waveview = SwiftSiriWaveformView()
    var change:CGFloat = 0.01
    typealias block = ()->Void
    var closeBlock: block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadUI()
                        self.startRecording()
                    } else {
                        // failed to record!
                        
                    }
                }
            }
        } catch {
            // failed to record!
        }
        


        
    }
    
    func startRecording() {

        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch let error{
            print(error.localizedDescription)
            finishRecording(success: false)
        }
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
        } else {
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadUI(){
        let closeBtn = UIButton()
        addSubview(closeBtn)
        addSubview(waveview)
        let saveBtn = UIButton()
        addSubview(saveBtn)
        
        closeBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        saveBtn.setImage(#imageLiteral(resourceName: "righticon"), for: .normal)
        waveview.amplitude = 1.0
        waveview.waveColor = UIColor.red
        waveview.backgroundColor = UIColor.white
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
        closeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        saveBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        waveview.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(closeBtn.snp.right)
            make.right.equalTo(saveBtn.snp.left)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(refreshAudioView), userInfo: nil, repeats: true)
    }
    internal func saveAction(){
        hideSelf()
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        finishRecording(success: true)

//        let siex = FileManager.default.fileExists(atPath: audioFilename.path)
//        do{
//            let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
//            
//            let dirsring = try FileManager.default.contentsOfDirectory(atPath: dirs[0])
//            print(dirsring)
//            
//            let attr = try FileManager.default.attributesOfItem(atPath: audioFilename.path)
//            let fileSize = attr[FileAttributeKey.size] as! UInt64
//            
//            print("size: ", fileSize)
//            
//        }catch let error{
//            print("-->", error.localizedDescription)
//        }
//        print(audioFilename.path,"存在：", siex)
        
    }
    internal func closeAction(){
        hideSelf()
        finishRecording(success: true)

        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        do{
            try FileManager.default.removeItem(at: audioFilename)
        }catch let error{
            print(error.localizedDescription)
        }
    }
    private func hideSelf(){
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 80)
        }) { (_) in
            self.timer.invalidate()
            self.closeBlock?()
        }

    }
    internal func refreshAudioView(_:Timer) {
        if waveview.amplitude <= waveview.idleAmplitude || self.waveview.amplitude > 1.0 {
            self.change *= -1.0
        }
        
        // Simply set the amplitude to whatever you need and the view will update itself.
        waveview.amplitude += self.change
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
