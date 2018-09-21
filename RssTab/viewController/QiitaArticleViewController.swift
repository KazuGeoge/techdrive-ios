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

class QiitaArticleViewController: UIViewController, TableProtocol {
   
    @IBOutlet weak var tableView: UITableView!
    let sectionTitle: Array = ["キータ一覧"]
    var tablePage : TableViewDataSouce = TableViewDataSouce()
    var cellTitle : [String] = []
    var cellURL : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
        loadAPI()
        
        tablePage.delegate = self
    }
    
    func configue() {
        tableView.frame = view.frame
        tablePage.sectionTitle = sectionTitle
        tableView.delegate = self.tablePage
        tableView.dataSource = self.tablePage
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func loadAPI() {
        let url:String = Const.qiita
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let title: String = ("\(json["title"])")
                        let url: String = ("\(json["url"])")
                        print("title:\(json["title"])")
                        print("Url:\(json["url"])")
                        print("profile_image_url:\(json["profile_image_url"])")
                        self.cellTitle.append(title)
                        self.cellURL.append(url)
                    }
                    self.tablePage.cellTitle = self.cellTitle
                    self.tablePage.cellURL = self.cellURL
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func pushWebVC(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
    }
}
