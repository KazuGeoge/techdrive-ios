//
//  WebViewDetailViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/12.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol favProtocol {
    func addFavCell(titleCell: String, url: URL)
}

class WebViewDetailViewController: UIViewController ,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var webUrl: URL?
    var barTitle : String = ""
    var webViewDelegate: favProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        title.textColor = UIColor.gray
        title.text = barTitle
        self.navigationItem.titleView = title
        
        webView.delegate = self
        let url = webUrl
        let urlRequest = URLRequest(url: url!)
        self.webView.loadRequest(urlRequest)
    }
    
    @IBAction func button(_ sender: Any) {
        webViewDelegate?.addFavCell(titleCell: barTitle, url: webUrl!)
        print("お気に入りに追加")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
