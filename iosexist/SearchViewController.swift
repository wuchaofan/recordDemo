//
//  SearchViewController.swift
//  iosexist


import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let headerview = UIView()
        view.addSubview(headerview)
        headerview.backgroundColor = UIColor.white
        headerview.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        
        view.backgroundColor = UIColor(hex: 0xE7E7E7)
        let navbar = UINavigationBar()
        view.addSubview(navbar)
        navbar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(20)
        }
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        
        let itembar = UINavigationItem()
        navbar.items = [itembar]
        
        let searchBar = UISearchBar()
        itembar.titleView = searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "搜索"
        searchBar.becomeFirstResponder()
        searchBar.tintColor = UIColor.black
        let textfield = searchBar.value(forKey: "searchField") as! UITextField
        textfield.backgroundColor = UIColor(hex: 0xE6E6E6)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension SearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
