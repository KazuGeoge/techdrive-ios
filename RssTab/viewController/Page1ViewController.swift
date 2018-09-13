//
//  ViewController.swift
//  TableView Rss取り込み
//
//  Created by 城島一輝 on 2018/09/09.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Page1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate  {
    
    //テーブルビューインスタンス作成
    var tableView: UITableView  =   UITableView()
    var parentController : TabsViewController?
    let webViewDetailController : WebViewDetailViewController = WebViewDetailViewController()
    var feedItems = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser: XMLParser! = XMLParser(contentsOf: feedUrl)
        parser.delegate = self
        parser.parse()
    
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    let sectionTitle: NSArray = ["IT 科学"]
    let feedUrl = URL(string: "https://news.yahoo.co.jp/pickup/computer/rss.xml")!
   
    // RSSパース中の現在の要素名
    var currentElementName : String!
    let itemElementName = "item"
    let titleElementName = "title"
    let linkElementName = "link"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // セクションの数
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // セクションの文字
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TableViewの数
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        // indexPathと同じ番号の配列を取得
        let feedItem = feedItems[indexPath.row]
        // Cellに値を設定
        cell.textLabel?.text = feedItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = feedItems[indexPath.row]
        // Storyboard のインスタンスを取得
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動するViewControllerを取得
        let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as! WebViewDetailViewController
        // URLを渡す
        webViewDetailVC.webUrl = URL(string: feedItem.url)
        webViewDetailVC.barTitle = feedItem.title
        // 遷移する
        self.navigationController?.pushViewController(webViewDetailVC, animated: true)
        print("記事URL:\(feedItem.title!)")
    }
    
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TableViewの高さ
        return 100.0
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElementName = nil
        if elementName == itemElementName {
            self.feedItems.append(FeedItem())
        } else {
            currentElementName = elementName
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.feedItems.count > 0 {
            let lastItem = self.feedItems[self.feedItems.count - 1]
            switch self.currentElementName {
            case titleElementName:
                let tmpString = lastItem.title
                lastItem.title = (tmpString != nil) ? tmpString! + string : string
            case linkElementName:
                lastItem.url = string
            default: break
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
}

