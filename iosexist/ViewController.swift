//
//  ViewController.swift
//  iosexist
//

import UIKit
import SwiftHEXColors
import SnapKit

class ViewController: UIViewController {
    
    let containerView = ContainerView()
    
    let leftSideView = LeftSideView(frame: CGRect.zero)
    
    let leftSideWidth:CGFloat = 240

    let datalist:[Int] = [0,1,0,1,1,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(openTakePhoto), name: .openTakePhoto, object: nil)
        view.backgroundColor = UIColor(hex: 0x262e34)

        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        containerView.config(self,frame: view.frame)
        leftsidePage()
        
        containerView.tableView.dataSource = self
        containerView.tableView.backgroundColor = UIColor.clear
        containerView.tableView.delegate = self
        containerView.tableView.separatorStyle = .none
        containerView.tableView.rowHeight = 100
        containerView.tableView.sectionHeaderHeight = 10
        containerView.tableView.showsVerticalScrollIndicator = false
        containerView.tableView.showsHorizontalScrollIndicator = false
        
//        containerView.tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: "cell")
        
        containerView.tableView.register(ImageCell.self, forCellReuseIdentifier: "imagecell")
        containerView.tableView.register(TextCell.self, forCellReuseIdentifier: "textcell")
    }
    
 
    
    func openTakePhoto(){
        
        let vc = TakePhotoViewController()
        present(vc, animated: true, completion: nil)
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)
//        }
    }
    

    
    func leftsidePage (){
        self.view.insertSubview(leftSideView, belowSubview: self.containerView)
        leftSideView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(leftSideWidth)
        }
        leftSideView.feedbackBlock = {[unowned self] title in
            let feedbackVC = WebViewController()
            feedbackVC.title = title
            feedbackVC.urlString = "https://www.baidu.com/"
            self.navigationController?.pushViewController(feedbackVC, animated: true)

        }
        leftSideView.termsBlock = {[unowned self] title in
            let termVC = WebViewController()
            termVC.title = title
            termVC.urlString = "https://www.baidu.com/"
            self.navigationController?.pushViewController(termVC, animated: true)
        }
        leftSideView.privateBlock = {[unowned self] title in
            let vc = WebViewController()
            vc.title = title
            vc.urlString = "https://www.baidu.com/"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        leftSideView.helpBlock = {[unowned self] title in
            let vc = WebViewController()
            vc.title = title
            vc.urlString = "https://www.baidu.com/"

            self.navigationController?.pushViewController(vc, animated: true)
        }
        leftSideView.settingsBlock = {[unowned self] _ in
            
            let settingsVC = SettingsViewController()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }



    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = ContentListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = datalist[indexPath.item]
  
        if cellType == 0{
            let imagecell =  tableView.dequeueReusableCell(withIdentifier: "imagecell", for: indexPath) as! ImageCell
            cellAction(imagecell,indexPath: indexPath)
            return imagecell
        }else{
            let textcell =  tableView.dequeueReusableCell(withIdentifier: "textcell", for: indexPath) as! TextCell
            cellAction(textcell,indexPath: indexPath)
            textcell.showMuliView(true)
            textcell.titleLabel.text = "记录每一天"
            textcell.summaryLabel.text = "人生的磨难是很多的，所以我们不可对于每一件轻微的伤害都过于敏感。在生活磨难面前，精神上的坚强和无动于衷是我们抵抗罪恶和人生意外的最好武器"
            return textcell
        }
        
        
    }
    
    func cellAction(_ cell: CommonTableViewCell, indexPath: IndexPath){
        cell.deleteCall = { 
            print("delete: ",indexPath.row)
        }
        cell.shareCall = {
            print("share: ", indexPath.row)
        }
        cell.tagCall = {
            print("tag: ", indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
extension ViewController:UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
}
