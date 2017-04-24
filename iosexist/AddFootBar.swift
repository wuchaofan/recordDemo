//
//  AddFootBar.swift
//  iosexist
//


import UIKit
import AVFoundation

extension Notification.Name {
    
    static let openTakePhoto = Notification.Name("openTakePhoto")
}

class AddFootBar: UIView {
    let xView = UIView()
    let textView = UITextView()
    let blowView = UIView()
    
    var recordView: RecordView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        blowView.layer.shadowColor = UIColor.gray.cgColor
        blowView.layer.shadowRadius = 1
        blowView.layer.shadowOpacity = 1
        
     
        textView.text = "撰写..."
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        blowView.backgroundColor = UIColor(hex: 0x6aa6b1)

        blowView.addSubview(textView)
        textView.delegate = self
        let carmBtn = UIButton()
        carmBtn.setImage(#imageLiteral(resourceName: "actionbar_takephoto_24x20_"), for: .normal)
        blowView.addSubview(carmBtn)
        carmBtn.addTarget(self, action: #selector(takePhotoAction), for: .touchUpInside)

        let audioBtn = UIButton()
        audioBtn.setImage(#imageLiteral(resourceName: "actionbar_voice_16x21"), for: .normal)
        audioBtn.addTarget(self, action: #selector(recordAction), for: .touchUpInside)
        blowView.addSubview(audioBtn)
        carmBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 24, height: 20))
        }
        audioBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(carmBtn.snp.left).offset(-15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        textView.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(audioBtn.snp.left).offset(5)
        }
        addSubview(blowView)
        blowView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        blowView.addSubview(xView)
        textView.showsVerticalScrollIndicator = true
        textView.showsHorizontalScrollIndicator = true
        textView.font = UIFont.systemFont(ofSize: 18)
//        xView.addSubview(textView)
        xView.backgroundColor = UIColor.white
        let sureBtn = UIButton()
        xView.addSubview(sureBtn)
        sureBtn.setImage(#imageLiteral(resourceName: "righticon"), for: .normal)
        sureBtn.clipsToBounds = true
        sureBtn.addTarget(self, action: #selector(makeSureAction), for: .touchUpInside)
        xView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.textView.snp.right)
        }
        sureBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
       xView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func recordAction(){

        recordView = RecordView(frame: CGRect.zero)
        recordView?.closeBlock = {
            self.recordView?.removeFromSuperview()

                self.backgroundColor = UIColor.clear
                self.blowView.isHidden = false
            
                UIView.animate(withDuration: 0.2, animations: {
                    self.snp.updateConstraints { (make) in
                        make.height.equalTo(44)
                    }
                    self.blowView.transform = CGAffineTransform(translationX: 0, y: 0)

                    self.superview?.layoutIfNeeded()
                }, completion: { (_) in
                    
                })
            

        }
        addSubview(recordView!)
        recordView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        })
        recordView?.transform = CGAffineTransform(translationX: 0, y: 80)
        recordView?.backgroundColor = UIColor.white
        
            UIView.animate(withDuration: 0.2, animations: {
                self.blowView.transform = CGAffineTransform(translationX: 0, y: 44)
            }) { (_) in
                self.blowView.isHidden = true
                self.snp.updateConstraints { (make) in
                    make.height.equalTo(UIScreen.main.bounds.height)
                }
                self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.3)
                
                UIView.animate(withDuration: 0.2, animations: { 
                    self.recordView?.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: { (_) in
                    
                })
            }
        
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //var player: AVAudioPlayer?
    
    func takePhotoAction(){
        //NSNotification.Name("")
        NotificationCenter.default.post(name: .openTakePhoto, object: nil)
        

        
//        let alertSound = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//        print(URL(fileURLWithPath: alertSound.path))
        //let path = Bundle.main.path(forResource: "逆流成河", ofType: "mp3")
        //print(path ?? "")
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            let data = try Data(contentsOf: alertSound)
//
//            player = try AVAudioPlayer(data: data)
//            
//            player?.prepareToPlay()
//            player?.volume = 1.0
//            player?.delegate = self
//            
//            player?.play()
//        } catch let error {
//            print(error.localizedDescription)
//        }
    }
    func keyboardWillShow(notify: Notification){
        guard let userInfo = notify.userInfo else {
            return
        }
        if let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
          //  var rect = self.frame
          //  rect.origin.y += endFrame.height
            

            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.snp.updateConstraints { (make) in
                                make.height.equalTo(UIScreen.main.bounds.height)
                            }
                            
                            self.blowView.snp.updateConstraints{ (make) in
                                make.bottom.equalToSuperview().offset(-endFrame.height)
                                make.height.equalTo(100)
                            }
                            
                   self.superview?.layoutIfNeeded()
            },completion: nil)
        }
    }
    func keyboardWillHide(notify: Notification){
        guard let userInfo = notify.userInfo else {
            return
        }
        if let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            print("hide - frame: ", endFrame)
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.snp.updateConstraints { (make) in
                                make.height.equalTo(44)
                            }
                            self.blowView.snp.updateConstraints{ (make) in
                                make.bottom.equalToSuperview()
                                make.height.equalTo(44)
                            }
                            self.superview?.layoutIfNeeded()
            },completion: { _ in
                self.makeSureAction()
            })
            
        }
    }
    func makeSureAction(){
        
        textView.resignFirstResponder()
        blowView.endEditing(true)
        textView.text = "撰写..."
        textView.textColor = UIColor.white
        self.xView.isHidden = true
        blowView.backgroundColor = UIColor(hex: 0x6aa6b1)

    }
    func inputContent(){
        
        xView.isHidden = false
        blowView.backgroundColor = UIColor.white
        textView.becomeFirstResponder()
        textView.text = ""
        textView.textColor = UIColor.black
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

}

extension AddFootBar: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
        inputContent()
    }
}
