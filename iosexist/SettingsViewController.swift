//
//  SettingsViewController.swift
//  iosexist
//


import UIKit

class SettingsViewController: UIViewController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //title =
        view.backgroundColor = UIColor.white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let navView = UIView()
        navView.backgroundColor = UIColor(hex: 0xFF0033, alpha: 0.8)
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        let titleLabel = UILabel()
        navView.addSubview(titleLabel)
        titleLabel.text = "应用设置"
        titleLabel.textColor = UIColor.white
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(12)
        }
        let backBtn = UIButton()
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        navView.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    func backAction(){
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }



}
