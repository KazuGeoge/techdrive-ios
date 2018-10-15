//
//  TabsViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/11.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

enum ArticleViews {
    case yahooTech
    case qiita
    case yahooInterNational
    case yahooEconomy
}

class TabsViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllers: [UIViewController] = []
        let articleViews = ["yahooTech", "qiita", "yahooInterNational", "yahooEconomy"]
        
        // 記事を表示するViewControllerをインスタンス化
        for articleViewName in articleViews {
            if let articleView = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
                
                switch articleViewName {
                    
                case "yahooTech":
                    articleView.sectionTitles = [Const.TECHTITLE]
                    articleView.tabBarItem.title = Const.TECHTITLE
                    articleView.feedURL = URL(string: Const.TECH)
                    
                case "qiita":
                    articleView.sectionTitles = [Const.QIITATITLE]
                    articleView.tabBarItem.title = Const.QIITATITLE
                    articleView.feedLink = Const.QIITA
                    articleView.isJson = true
                    
                case "yahooInterNational":
                    articleView.sectionTitles = [Const.INTERNATIONALTITLE]
                    articleView.tabBarItem.title = Const.INTERNATIONALTITLE
                    articleView.feedURL = URL(string: Const.INTERNATIONAL)
                    
                case  "yahooEconomy":
                    articleView.sectionTitles = [Const.ECONOMYTITLE]
                    articleView.tabBarItem.title = Const.ECONOMYTITLE
                    articleView.feedURL = URL(string: Const.ECONOMY)
                    
                default:
                    break
                }
                viewControllers.append(articleView)
            }
        }
        
        // 検索のViewControllerをインスタンス化
        if let searchVC = mainStoryboard.instantiateViewController(withIdentifier: "SearchView") as? SearchViewController {
            viewControllers.append(searchVC)
            searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        }
        // ページをセット
        self.setViewControllers(viewControllers, animated: false)
    }
}
