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

class Page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var contentList: [Content] = []
    let tableView: UITableView  =   UITableView()
    let sectionTitle: NSArray = ["キータ一覧"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        loadAPI()
    }
    
    func loadAPI() {
        let url:String = "https://qiita.com/api/v2/items"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        print("title:\(json["title"])")
                        print("Url:\(json["url"])")
                        let content = Content.getContent(json: json)
                        self.contentList.append(content)
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureTableView() {
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView,titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let feedItem = contentList[indexPath.row]
        cell.textLabel?.text = feedItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = self.contentList[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as! WebViewDetailViewController
        webViewDetailVC.webUrl = URL(string: feedItem.url)
        webViewDetailVC.barTitle = feedItem.title
        self.navigationController?.pushViewController(webViewDetailVC, animated: true)
        print("記事URL:\(feedItem.url)")
    }
    
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
