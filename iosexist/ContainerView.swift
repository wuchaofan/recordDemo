//
//  ContainerView.swift
//  iosexist
//


import UIKit

class ContainerView: UIView {

    var sortview: SortView!
    let leftSideWidth:CGFloat = 240
    var parentVC: UIViewController?
    let tableView = HomeTableView(frame: CGRect.zero, style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addNavBar()
        
        sortview = SortView(frame: CGRect.zero)

        addSubview(sortview!)
        bringSubview(toFront: sortview!)
        sortview?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(swipecall))
        swipeleft.direction = .left
        addGestureRecognizer(swipeleft)
    }
    
    func swipecall(){
        var frame = self.frame
        if frame.origin.x != 0{
            frame.origin.x = 0
            tableView.isUserInteractionEnabled = true
            
        }
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 15,
                       options: .curveEaseInOut, animations: {
                        self.frame = frame
        }) { _ in
        }

    }
    
    func config(_ nav: UIViewController?,frame: CGRect){
        let gradientlayer = CAGradientLayer()
        
        gradientlayer.startPoint = CGPoint(x: 1, y: 0)
        gradientlayer.endPoint = CGPoint(x: 0, y: 1)
        gradientlayer.frame = frame
        gradientlayer.colors = [UIColor(hex: 0x66d0a3)!.cgColor,UIColor(hex: 0x6aa6b1)!.cgColor]
        layer.insertSublayer(gradientlayer, at: 0)
        
        parentVC = nav
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addNavBar() {
        
        let containerView = self
        
        let navbar = UINavigationBar(frame: CGRect.zero)
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.barStyle = .black
        navbar.barTintColor = UIColor.white
        
        containerView.addSubview(navbar)
        
        navbar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        let navitem = UINavigationItem(title: "存在")
        navbar.items = [navitem]
        navbar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
        
        let menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        let leftMenuBar = UIBarButtonItem(customView: menuBtn)
        menuBtn.addTarget(self, action:  #selector(showLeftSide), for: .touchUpInside)
        navitem.leftBarButtonItem = leftMenuBar
        
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        searchBtn.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        searchBtn.addTarget(self, action: #selector(openSearchVC), for: .touchUpInside)
        let searchBar = UIBarButtonItem(customView: searchBtn)
        
        
        let sortBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        sortBtn.setImage(#imageLiteral(resourceName: "lista"), for: .normal)
        sortBtn.addTarget(self, action: #selector(changeSortStyle), for: .touchUpInside)
        let sortBar = UIBarButtonItem(customView: sortBtn)
        
        let fixbar = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixbar.width = 20
        navitem.rightBarButtonItems = [sortBar,fixbar, searchBar]
        
        containerView.addSubview(tableView)

        let footView = AddFootBar()
        containerView.addSubview(footView)
        footView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)

            make.top.equalTo(navbar.snp.bottom)
            make.bottom.equalToSuperview().offset(-44)
        }
        
    }


    func showLeftSide() {

        var frame = self.frame
        if frame.origin.x == 0{
            frame.origin.x = leftSideWidth
            tableView.isUserInteractionEnabled = false
            
        }else{
            frame.origin.x = 0
            tableView.isUserInteractionEnabled = true

        }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 15,
            options: .curveEaseInOut, animations: {
            self.frame = frame
        }) { _ in
        }

        
    }
    
    func changeSortStyle() {
        sortview.isHidden = false
    }

    func openSearchVC () {
        let vc = SearchViewController()
        vc.modalTransitionStyle = .crossDissolve
        parentVC?.present(vc, animated: true, completion: nil)
    }
    
}

