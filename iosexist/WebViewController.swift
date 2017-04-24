//
//  WebViewController.swift
//  iosexist
//


import UIKit
import WebKit

class WebViewController: UIViewController {

    var webview: WKWebView?
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let config = WKWebViewConfiguration()
        webview = WKWebView(frame: CGRect.zero, configuration: config)
        view.addSubview(webview!)
        webview?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let url = URL(string: urlString!)
        webview?.load(URLRequest(url: url!))
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    func loadUrl(_ string: String){
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
