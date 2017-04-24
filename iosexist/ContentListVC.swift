//
//  ContentListVC.swift
//  iosexist
//


import UIKit

class ContentListVC: UIViewController, UIGestureRecognizerDelegate {

    let scrollView = UIScrollView()
    let navbar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gradientlayer = CAGradientLayer()
        
        gradientlayer.startPoint = CGPoint(x: 1, y: 0)
        gradientlayer.endPoint = CGPoint(x: 0, y: 1)
        gradientlayer.frame = view.frame
        gradientlayer.colors = [UIColor(hex: 0x66d0a3)!.cgColor,UIColor(hex: 0x6aa6b1)!.cgColor]
        view.layer.insertSublayer(gradientlayer, at: 0)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        addNavBar()
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navbar.snp.bottom)
        }
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(200)
        }
    }
    func addNavBar () {
        view.addSubview(navbar)
        navbar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.tintColor = UIColor.white
        
        let itemnav = UINavigationItem(title: "")
        navbar.items = [itemnav]
        let fixeditem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixeditem.width = -6
        
        let leftitem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backAction))
       // let leftitem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backAction))
        itemnav.leftBarButtonItems = [fixeditem, leftitem]
        
        let sharebtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        sharebtn.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        let shareitem = UIBarButtonItem(customView: sharebtn)
        let deletebtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        deletebtn.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        let deleteitem = UIBarButtonItem(customView: deletebtn)
        
        let fixeditem1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixeditem1.width = 15
        itemnav.rightBarButtonItems = [shareitem ,fixeditem1, deleteitem]
        
    }
    func backAction(){
        navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
