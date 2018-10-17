//
//  WebViewDetailViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/12.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit
import WebKit

protocol FavProtocol {
    func addFavCell(titleCell: String, webURL: URL)
}

class WebViewDetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    var webURL: URL?
    var barTitle: String?
    var webViewDelegate: FavProtocol?
    var errorPage = URL(string: Const.ERROR_PAGE)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel()
        title.textColor = UIColor.gray
        title.text = barTitle
        navigationItem.titleView = title
        loadWebView()
    }
    
    private func loadWebView() {
        // errorPageは定数のためnil無し
        let urlRequest = URLRequest(url: webURL ?? errorPage!)
        webView.load(urlRequest)
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    // 戻るボタンの設定
    @IBAction func actGoBack(_ sender: Any) {
        webView.goBack()
    }
    
    // 進むボタンの設定
    @IBAction func actGoForward(_ sender: Any) {
        webView.goForward()
    }
    
    // リロードボタンの設定
    @IBAction func reloadButton(_ sender: Any) {
        webView.reload()
    }
    
    // safariに飛ぶボタンの設定
    @IBAction func goSafariButton(_ sender: Any) {
        // その時開いているURLを取得
        if let nowWebViewURL = webView.url {
            UIApplication.shared.open(nowWebViewURL, options: [:], completionHandler: nil)
        }
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
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // インジケータの表示を開始する
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // ボタンの有効性をチェック
        goBackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // インジケータの表示を終了する
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // ボタンの有効性をチェック
        goBackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
        
    }
}
