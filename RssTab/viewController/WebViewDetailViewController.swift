//
//  WebViewDetailViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/12.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol FavProtocol {
    func addFavCell(titleCell: String, webURL: URL)
}

class WebViewDetailViewController: UIViewController ,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var webURL: URL?
    var barTitle: String = ""
    var webViewDelegate: FavProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        title.textColor = UIColor.gray
        title.text = barTitle
        navigationItem.titleView = title
        
        webView.delegate = self
        let urlRequest = URLRequest(url: webURL!)
        webView.loadRequest(urlRequest)
    }
    
    @IBAction func button(_ sender: Any) {
        webViewDelegate?.addFavCell(titleCell: barTitle, webURL: webURL!)
        print("お気に入りに追加")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
