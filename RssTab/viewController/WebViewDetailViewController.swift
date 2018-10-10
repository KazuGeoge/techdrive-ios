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
    var barTitle: String?
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
    
    // お気に入りを追加
    @IBAction func button(_ sender: Any) {
        
        let alertController = UIAlertController(
            title: "お気に入りに追加",
            message: "お気に入りに追加してよろしいですか？",
            preferredStyle: .alert
        )
        // キャンセルボタン
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        // OKボタン
        alertController.addAction(UIAlertAction(title: "OK!", style: .default, handler: {
            OKAction in self.webViewDelegate?.addFavCell(titleCell: self.barTitle!, webURL: self.webURL!)
            print("お気に入りに追加")
        }
            )
        )
        // アラートを表示
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
