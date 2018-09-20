//
//  WebViewDetailViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/12.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

class WebViewDetailViewController: UIViewController ,UIWebViewDelegate {

    var webView : UIWebView = UIWebView()
    var webUrl: URL?
    var barTitle : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        title.textColor = UIColor.gray
        title.text = barTitle
        self.navigationItem.titleView = title
       
        webView = UIWebView(frame : self.view.bounds)
        webView.delegate = self
        self.view.addSubview(webView)
        let url = webUrl
        let urlRequest = URLRequest(url: url!)
        self.webView.loadRequest(urlRequest)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
