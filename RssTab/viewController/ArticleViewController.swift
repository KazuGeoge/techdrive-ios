//
//  ArticleViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/27.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol JsonsLink {
    func loadAPI(link: String)
}

class ArticleViewController: UIViewController, TableProtocol, FavProtocol, ParsedXMLData, DecodedJsonData {

    @IBOutlet weak var tableView: UITableView!
    var sectionTitle = [""]
    var feedURL = URL(string: "")
    var feedLink = ""
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
    var readXML: ReadXML = ReadXML()
    var readJson: ReadJson = ReadJson()
    var jsonsLink: JsonsLink?
    var isXML: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAPIArticle()
        configureTableView()
    }
    
    private func configureTableView() {
        tableViewDataSouce.sectionTitle += sectionTitle
        tableViewDataSouce.tableDelegate = self
        tableViewDataSouce.favDelegate = self
        tableViewDataSouce.favDelegate = self
        tableView.delegate = tableViewDataSouce
        tableView.dataSource = tableViewDataSouce
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        view.addSubview(tableView)
    }
    
    private func loadAPIArticle() {
        // XMLファイルをパース
        if isXML == true {
            readXML.parsedXMLData = self
            // feedURLはConstで設定のためnilの可能性はなし
            let parser:XMLParser? = XMLParser(contentsOf: feedURL!)
            parser?.delegate = readXML
            parser?.parse()
        } else {
            // Jsonファイルをデコード
            readJson.decodedJsonData = self
            jsonsLink = readJson
            jsonsLink?.loadAPI(link: feedLink)
        }
    }
    // パースされたデータを設定
    func setXMLData(parsedCellTitle: [String], parsedCellURL: [String]) {
        tableViewDataSouce.cellTitle = parsedCellTitle
        tableViewDataSouce.cellLink = parsedCellURL
    }
    // デコードされたデータを設定
    func setJsonData(decodedCellTitle: [String], decodedCellLink: [String]) {
        tableViewDataSouce.cellTitle = decodedCellTitle
        tableViewDataSouce.cellLink = decodedCellLink
        tableView.reloadData()
    }
    // WebViewへの遷移
    func pushWebView(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
    }
    // お気に入りを追加
    func addFavCell(titleCell: String, webURL: URL) {
        var sortedCellTitle: [String] = []
        var sortedCellLink: [String] = []
        tableViewDataSouce.favCellTitle.append(titleCell)
        tableViewDataSouce.favCellURL.append(webURL)
            
        for title in tableViewDataSouce.cellTitle {
            if title != titleCell {
                sortedCellTitle.append(title)
            }
        }
            
        for link in tableViewDataSouce.cellLink {
            let convertURL = URL(string: link)
            if webURL != convertURL {
                sortedCellLink.append(link)
            }
        }
        tableViewDataSouce.cellTitle = sortedCellTitle
        tableViewDataSouce.cellLink = sortedCellLink
        tableView.reloadData()
    }
}
