//
//  TableViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/17.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol TableProtocol: NSObjectProtocol {
    func pushViewController(webView: UIViewController)
}

protocol EditingCell {
    func editCell()
}

class TableViewDataSouce: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var feedItems: [FeedItem] = []
    private var contentLists: [BaseContent] = []
    var sectionTitles: [String] = ["お気に入り"]
    var searchSection: [String] = ["検索中..."]
    var cellTitles: [String] = []
    var cellLinks: [String] = []
    var imageLinks: [String] = []
    var favCellTitles: [String] = []
    var searchResultTitle: [String] = []
    var searchResultLinks: [String] = []
    var favCellURLs: [URL] = []
    var tableDelegate: TableProtocol?
    var favDelegate: FavProtocol?
    var isFromSearchView: Bool?
    var editingCell: EditingCell?
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isFromSearchView == true {
            return searchSection[section]
        } else {
            return sectionTitles[section]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        
        if section == 0 {
            if isFromSearchView == true {
                cellCount += searchResultTitle.count
                return cellCount
            } else {
                cellCount += favCellTitles.count
                return cellCount
            }
        } else if section == 1 {
            cellCount += cellTitles.count
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return feedItems(indexPath: indexPath)
    }
    
    func feedItems(indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
        if indexPath.section == 0 {
            if isFromSearchView == true {
                let feedItem = searchResultTitle[indexPath.row]
                cell.textLabel?.text = feedItem
                return cell
            } else {
                let feedItem = favCellTitles[indexPath.row]
                cell.textLabel?.text = feedItem
                return cell
            }

        } else if indexPath.section == 1 {
            let feedItem = cellTitles[indexPath.row]
            cell.textLabel?.text = feedItem
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as? WebViewDetailViewController {
            
            if indexPath.section == 0 {
                if isFromSearchView == true {
                    let feedItem = searchResultLinks[indexPath.row]
                    webViewDetailVC.webURL = URL(string: feedItem)
                    let title = searchResultTitle[indexPath.row]
                    webViewDetailVC.barTitle = title
                    tableDelegate?.pushViewController(webView: webViewDetailVC)
                } else {
                    webViewDetailVC.webURL = favCellURLs[indexPath.row]
                    let title = favCellTitles[indexPath.row]
                    webViewDetailVC.barTitle = title
                    tableDelegate?.pushViewController(webView: webViewDetailVC)
                }
            } else if indexPath.section == 1 {
                let feedItem = cellLinks[indexPath.row]
                webViewDetailVC.webURL = URL(string: feedItem)
                let title = cellTitles[indexPath.row]
                webViewDetailVC.barTitle = title
                webViewDetailVC.webViewDelegate = favDelegate
                tableDelegate?.pushViewController(webView: webViewDetailVC)
                print("記事URL:\(feedItem)")
            }
        }
    }
    // Cellのデータを削除した後に親ビューにTableViewのReloadを委譲する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if isFromSearchView == true {
                searchResultTitle.remove(at: indexPath.row)
                searchResultLinks.remove(at: indexPath.row)
            } else {
                cellTitles.insert(favCellTitles[indexPath.row], at: 0)
                do {
                    let favURLsString = try String(contentsOf: favCellURLs[indexPath.row])
                    cellLinks.insert(favURLsString, at: 0)
                }
                catch _ {
                    cellLinks.append("")
                }
                favCellTitles.remove(at: indexPath.row)
                favCellURLs.remove(at: indexPath.row)
            }
        } else if indexPath.section == 1 {
            cellTitles.remove(at: indexPath.row)
            cellLinks.remove(at: indexPath.row)
        }
        editingCell?.editCell()
    }
    
     func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
