//
//  LeftSideView.swift
//  iosexist
//

import UIKit

class LeftSideView: UIView {

    private let menuListView = UIView()
    typealias block = (_ text: String)->Void
    var feedbackBlock: block?
    var termsBlock: block?
    var privateBlock: block?
    var helpBlock: block?
    var settingsBlock: block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x262e34)

        leftsidePage()
    }
    private func leftsidePage () {
        let topView = UIView()
        self.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
        let avatarView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        topView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.gray
        nameLabel.text = "凡人凡语"
        topView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(avatarView.snp.centerX)
            make.top.equalTo(avatarView.snp.bottom).offset(6)
        }
        
        
        let footview = UILabel()
        addSubview(footview)
        footview.text = "版本: " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
        footview.textAlignment = .center
        footview.textColor = UIColor.lightGray
        
        footview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)

        }
        
        addSubview(menuListView)
        menuListView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.bottom.equalTo(footview.snp.top).offset(-5)
        }
        
        let feedbackBtn = createBtn(1,"意见反馈", #imageLiteral(resourceName: "feedback"),before: nil)
        let termsBtn = createBtn(2,"使用条款", #imageLiteral(resourceName: "book"), before: feedbackBtn)
        let privateBtn = createBtn(3,"隐私声明", #imageLiteral(resourceName: "lock"), before: termsBtn)
        let helpBtn = createBtn(4,"帮助中心", #imageLiteral(resourceName: "help"), before: privateBtn)
        _ = createBtn(5,"应用设置", #imageLiteral(resourceName: "settings"), before: helpBtn)
    }
    
    func btnAction (btn: UIButton){
        if let b = btn as? CustonButton{
            print(b.id)
            let text = b.title(for: .normal)!
            switch b.id {
            case 1:
                feedbackBlock?(text)
            case 2:
                termsBlock?(text)
            case 3:
                privateBlock?(text)
            case 4:
                helpBlock?(text)
            case 5:
                settingsBlock?(text)
            default:
                break
            }
        }
        
    }
    private func createBtn(_ at: Int, _ name: String,_ image: UIImage,before: UIView?) -> UIButton{
        
        let Btn = CustonButton()
        Btn.setImage(image, for: .normal)
        Btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        Btn.setTitle(name, for: .normal)
        
        Btn.id = at
        
        Btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        menuListView.addSubview(Btn)
        if before == nil{
            Btn.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(60)
            }
        }else{
            Btn.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(before!.snp.bottom).offset(1)
                make.width.equalToSuperview()
                make.height.equalTo(before!.snp.height)
            }
        }
        return Btn
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
fileprivate class CustonButton: UIButton{
    var id: Int = 0
}
