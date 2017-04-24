//
//  ImageCell.swift
//  iosexist
//


import UIKit

class ImageCell: CommonTableViewCell {

    let mainImageVIew = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        topView.addSubview(mainImageVIew)
        mainImageVIew.contentMode = .scaleAspectFill
        mainImageVIew.image = #imageLiteral(resourceName: "was")
        mainImageVIew.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        mainImageVIew.isUserInteractionEnabled = true
        mainImageVIew.clipsToBounds = true
        mainImageVIew.layer.cornerRadius = 6
    }
    
    override func showMuliView(_ show: Bool) {
        super.showMuliView(show)
        if show{
            mainImageVIew.snp.updateConstraints({ (make) in
                make.right.equalToSuperview().offset(-12)
            })
        }else{
            mainImageVIew.snp.updateConstraints({ (make) in
                make.right.equalToSuperview()
            })
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
