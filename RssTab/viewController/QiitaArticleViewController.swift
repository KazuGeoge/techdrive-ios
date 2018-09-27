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

class QiitaArticleViewController: UIViewController, TableProtocol, FavProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    let sectionTitle: Array = ["キータ一覧"]
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
    var contentList: [BaseContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadAPI()
        tableViewDataSouce.delegate = self
        tableViewDataSouce.favDelegate = self
    }
    
    private func configureTableView() {
        tableView.frame = view.frame
        tableViewDataSouce.sectionTitle += sectionTitle
        tableView.delegate = self.tableViewDataSouce
        tableView.dataSource = self.tableViewDataSouce
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func loadAPI() {
        let URL:String = Const.QIITA
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let content = BaseContent(json: json)
                        self.contentList.append(content)
                        
                         self.tableViewDataSouce.cellTitle.append(content.title)
                         self.tableViewDataSouce.cellLink.append(content.link)
                         self.tableViewDataSouce.imageLink.append(content.image)
                    }
                }
            case .failure(let error):
                print(error)
            }
             self.tableView.reloadData()
        }
    }
    
    func pushWebVC(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
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
