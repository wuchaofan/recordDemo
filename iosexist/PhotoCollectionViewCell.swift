//
//  PhotoCollectionViewCell.swift
//  iosexist
//


import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(frame: CGRect.zero)
    let selectBtn = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(6)
            make.right.bottom.equalToSuperview().offset(-6)
        }
        selectBtn.backgroundColor = UIColor.black
        selectBtn.layer.cornerRadius = 8
        selectBtn.layer.borderColor = UIColor.white.cgColor
        selectBtn.layer.borderWidth = 1
        
        imageView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-3)
            make.size.equalTo(CGSize(width: 16,height: 16))
        }
        
        selectBtn.setImage(#imageLiteral(resourceName: "success"), for: .selected)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
