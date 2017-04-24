//
//  SortView.swift
//  iosexist
//


import UIKit

class SortView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(colseview))
        self.addGestureRecognizer(tap)
        let menuView = UIView()

        addSubview(menuView)
        menuView.backgroundColor = UIColor.black
        
        menuView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(64)
            make.size.equalTo(CGSize(width: 120, height: 80))
        }
        
        let itemview1 = UIView()
        let itemview2 = UIView()
        menuView.addSubview(itemview1)
        menuView.addSubview(itemview2)
        menuView.layer.cornerRadius = 4
        menuView.layer.masksToBounds = true
        
        itemview1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(10)
        }
        
        itemview2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(itemview1.snp.bottom)
            make.height.equalTo(30)
        }
        
        let label1 = UILabel()
        label1.text = "按时间分类"
        label1.textColor = UIColor.white
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.textAlignment = .center
        
        let imagev1 = UIImageView(image: #imageLiteral(resourceName: "time"))
        let label2 = UILabel()
        label2.text = "按标签分类"
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.textColor = UIColor.white
        label2.textAlignment = .center
        
        let imagev2 = UIImageView(image: #imageLiteral(resourceName: "tag"))

        itemview1.addSubview(imagev1)
        itemview1.addSubview(label1)
        itemview2.addSubview(label2)
        itemview2.addSubview(imagev2)

        imagev1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(imagev1.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
        imagev2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()

        }
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(imagev2.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
        drawTriangle(size: 10, x: UIScreen.main.bounds.width-30,y: 54, up: true)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(selectTimeKind))
        itemview1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(selectTagKind))
        itemview2.addGestureRecognizer(tap2)
    }
    
    func selectTimeKind(){
        isHidden = true
    }
    func selectTagKind() {
        isHidden = true
    }
    private func drawTriangle( size: CGFloat, x: CGFloat, y: CGFloat, up:Bool) {
        
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        trianglePath.move(to: .zero)
        trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
        trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
        trianglePath.close()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.black.cgColor
        triangleLayer.anchorPoint = .zero
        triangleLayer.position = CGPoint(x: x, y: y)
        triangleLayer.name = "triangle"
        layer.addSublayer(triangleLayer)
    }

    
    
    func colseview(){
        self.isHidden = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
