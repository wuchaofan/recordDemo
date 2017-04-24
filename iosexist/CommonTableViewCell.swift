//
//  CommonTableViewCell.swift
//  iosexist
//


import UIKit
import SwiftSVG

class CommonTableViewCell: UITableViewCell {

    let topView = TopCellView()

    typealias callblock = ()->Void
    
    var shareCall: callblock?
    var tagCall: callblock?
    var deleteCall: callblock?
    
    
    private let muliView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func config() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        let bottomView = UIView()
        contentView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor(hex: 0xE7E7E7, alpha: 0.6)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 6
        
        let shareBtn = UIButton()
        shareBtn.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        bottomView.addSubview(shareBtn)
        shareBtn.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 38, height: 38))
        })
        shareBtn.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        
        let tagBtn = UIButton()
        tagBtn.setImage(#imageLiteral(resourceName: "tagq"), for: .normal)
        bottomView.addSubview(tagBtn)
        tagBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(shareBtn.snp.left).offset(-18)
        }
        tagBtn.addTarget(self, action: #selector(tagAction), for: .touchUpInside)

        
        let deleteBtn = UIButton()
        deleteBtn.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        bottomView.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 28))
            make.right.equalTo(tagBtn.snp.left).offset(-18)
        }
        deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)

        
        
        bottomView.addSubview(topView)
        topView.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 0.2)
        topView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        topView.addSubview(muliView)
        muliView.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 0.5)

        muliView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-6)
        }
        muliView.isHidden = true
        muliView.clipsToBounds = true
        muliView.layer.cornerRadius = 6
    }
    func showMuliView(_ show: Bool){
        muliView.isHidden = !show
    }
    func shareAction(){
        shareCall?()
    }
    func tagAction() {
        tagCall?()
    }
    func deleteAction(){
        deleteCall?()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        let initX = topView.superview!.frame.width/2

        topView.center = CGPoint(x: initX, y: topView.center.y )

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
