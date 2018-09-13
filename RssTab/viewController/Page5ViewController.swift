//
//  ViewController.swift
//  TableView Rss取り込み
//
//  Created by 城島一輝 on 2018/09/09.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

class Page5ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate  {
    //テーブルビューインスタンス作成
    var tableView: UITableView  =   UITableView()
    let sectionTitle: NSArray = ["エンタメニュース"]
    let feedUrl = URL(string: "https://headlines.yahoo.co.jp/rss/all-c_ent.xml")!
    var feedItems = [FeedItem]()
    var currentElementName : String!
    let itemElementName = "item"
    let titleElementName = "title"
    let linkElementName = "link"
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let feedItem = self.feedItems[indexPath.row]
        cell.textLabel?.text = feedItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = self.feedItems[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as! WebViewDetailViewController
        
        webViewDetailVC.webUrl = URL(string: feedItem.url)
        self.navigationController?.pushViewController(webViewDetailVC, animated: true)
        print("記事URL:\(feedItem.url)")
    }
    
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
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





