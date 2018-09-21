//
//  ViewController.swift
//  TableView Rss取り込み
//
//  Created by 城島一輝 on 2018/09/09.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

class YahooInternationalArticleViewController: UIViewController, XMLParserDelegate, TableProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    let sectionTitle: Array = ["国際ニュース"]
    private let feedUrl = URL(string: Const.international)
    private var feedItems = [FeedItem]()
    private var currentElementName : String?
    private let itemElementName = "item"
    private let titleElementName = "title"
    private let linkElementName = "link"
    var tablePage : TableViewDataSouce = TableViewDataSouce()
    var cellTitle : [String] = []
    var cellURL : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseXML()
        configureTable()
        
        tablePage.delegate = self
    }
    
    private func parseXML() {
        let parser: XMLParser! = XMLParser(contentsOf: feedUrl!)
        parser.delegate = self
        print("parse:\(parser.parse())")
    }
    
    private func configureTable(){
        tablePage.sectionTitle = sectionTitle
        tableView.delegate = self.tablePage
        tableView.dataSource = self.tablePage
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
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
            var lastItem = self.feedItems[self.feedItems.count - 1]
            
            switch self.currentElementName {
            case titleElementName:
                let tmpString = lastItem.title
                lastItem.title = tmpString + string
                cellTitle.append(lastItem.title)
                tablePage.cellTitle += cellTitle
            case linkElementName:
                lastItem.url = string
                cellURL.append(lastItem.url)
                tablePage.cellURL = cellURL
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func pushWebVC(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
    }
}
