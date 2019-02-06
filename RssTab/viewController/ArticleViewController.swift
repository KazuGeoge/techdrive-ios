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

class ArticleViewController: UIViewController, TableProtocol, FavProtocol, ParsedXMLData, DecodedJsonData, EditingCell {

    @IBOutlet weak var tableView: UITableView!
    var sectionTitles: [String] = []
    var feedURL: URL?
    var feedLink: String?
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
    var readXML: ReadXML = ReadXML()
    var readJson: ReadJson = ReadJson()
    var jsonsLink: JsonsLink?
    var isJson: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAPIArticle()
        configureTableView()
    }
    
    // TableViewのDelegateを設定
    private func configureTableView() {
        tableViewDataSouce.sectionTitles += sectionTitles
        tableViewDataSouce.tableDelegate = self
        tableViewDataSouce.favDelegate = self
        tableViewDataSouce.editingCell = self
        tableView.delegate = tableViewDataSouce
        tableView.dataSource = tableViewDataSouce
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func loadAPIArticle() {
        // XMLファイルをパース
        if isJson == true {
            // Jsonファイルをデコード
            readJson.decodedJsonData = self
            jsonsLink = readJson
            // Constで設定のためにnil無し
            jsonsLink?.loadAPI(link: feedLink!)
        } else {
            readXML.parsedXMLData = self
            // feedURLはConstで設定のためnil無し
            let parser:XMLParser? = XMLParser(contentsOf: feedURL!)
            parser?.delegate = readXML
            parser?.parse()
        }
    }
    
    // パースされたデータを設定
    func setXMLData(parsedCellTitles: [String], parsedCellURLs: [String]) {
        tableViewDataSouce.cellTitles = parsedCellTitles
        tableViewDataSouce.cellLinks = parsedCellURLs
    }
    
    // デコードされたデータを設定
    func setJsonData(decodedCellTitles: [String], decodedCellLinks: [String]) {
        tableViewDataSouce.cellTitles = decodedCellTitles
        tableViewDataSouce.cellLinks = decodedCellLinks
        tableView.reloadData()
    }
    
    // WebViewへの遷移
    func pushViewController(webView: UIViewController) {
        navigationController?.pushViewController(webView, animated: true)
    }
    
    // 編集されたTabelViewを適用する
    func editCell() {
        tableView.reloadData()
    }
    
    // お気に入りを追加
    func addFavCell(titleCell: String, webURL: URL) {
        tableViewDataSouce.favCellTitles.append(titleCell)
        tableViewDataSouce.favCellURLs.append(webURL)
        // 判定用にURLをString型に戻す
        let URLString = webURL.absoluteString
        // お気に入りされているタイトルを配列から外す
        tableViewDataSouce.cellTitles = tableViewDataSouce.cellTitles.filter {$0 != titleCell}
        tableViewDataSouce.cellLinks = tableViewDataSouce.cellLinks.filter {$0 != URLString}
        tableView.reloadData()
    }
    
    @IBAction func relaodButton(_ sender: Any) {
        loadAPIArticle()
        tableView.reloadData()
    }
}
