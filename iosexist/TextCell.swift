//
//  TextCell.swift
//  iosexist
//


import UIKit

class TextCell: CommonTableViewCell {

    let titleLabel = UILabel()
    let summaryLabel = UILabel()
    private let mainView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        topView.addSubview(mainView)
        mainView.backgroundColor = UIColor.white
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 6
        
        mainView.addSubview(titleLabel)
        mainView.addSubview(summaryLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        summaryLabel.numberOfLines = 0
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
       // summaryLabel.backgroundColor = UIColor.lightGray
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        summaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-20)
        }
    }
    override func showMuliView(_ show: Bool) {
        super.showMuliView(show)
        if show{
            mainView.snp.updateConstraints({ (make) in
                make.right.equalToSuperview().offset(-12)
            })
        }else{
            mainView.snp.updateConstraints({ (make) in
                make.right.equalToSuperview()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }


}
