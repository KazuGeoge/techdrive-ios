//
//  ViewController.swift
//  TableView Rss取り込み
//
//  Created by 城島一輝 on 2018/09/09.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit


class YahooTechArticleViewController: UIViewController, TableProtocol, FavProtocol, ParseXML {

    @IBOutlet weak var tableView: UITableView!
    let sectionTitle = ["IT 科学"]
    private let feedURL = URL(string: Const.TECH)
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
    var readXML: ReadXML = ReadXML()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSouce.sectionTitle += sectionTitle
        parseXML()
    }
    
    private func parseXML() {
        readXML.XMLdelegate = self
        let parser: XMLParser! = XMLParser(contentsOf: feedURL!)
        parser.delegate = self.readXML
        print("parse:\(parser.parse())")
    }

    func parse(parsedCellTitle: [String], parsedCellURL: [String]) {
        tableViewDataSouce.cellTitle = parsedCellTitle
        tableViewDataSouce.cellLink = parsedCellURL
        configureTableView()
    }
    
    func pushWebVC(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    private func configureTableView(){
        tableViewDataSouce.delegate = self
        tableViewDataSouce.favDelegate = self
        tableView.delegate = self.tableViewDataSouce
        tableView.dataSource = self.tableViewDataSouce
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        view.addSubview(tableView)
    }
    
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
