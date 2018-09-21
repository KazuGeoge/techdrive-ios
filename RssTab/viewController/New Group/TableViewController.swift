//
//  TableViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/17.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol TableProtocol : NSObjectProtocol {
    func pushWebVC(webView: UIViewController)
}

class TableViewDataSouce: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var sectionTitle: [String] = []
    var cellTitle : [String] = []
    var cellURL : [String] = []
    var feedItems = [FeedItem]()
    var delegate: TableProtocol?
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount: Int = 0
        if section == 0 {
            cellCount = cellTitle.count
        }
        return cellCount
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return feedItems(indexPath: indexPath)
    }
    
    func feedItems(indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        if indexPath.section == 0 {
        let feedItem = self.cellTitle[indexPath.row]
        cell.textLabel?.text = feedItem
        print("cellTitle:\(feedItem)")
        }
         return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = self.cellURL[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as! WebViewDetailViewController
        webViewDetailVC.webUrl = URL(string: feedItem)
        let title = feedItems(indexPath: indexPath)
        webViewDetailVC.barTitle = title.textLabel!.text!
        delegate?.pushWebVC(webView: webViewDetailVC)
        print("記事URL:\(feedItem)")
    }
    
     func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
