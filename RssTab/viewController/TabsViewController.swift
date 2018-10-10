//
//  TabsViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/11.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllers: [UIViewController] = []
        let articleViews = ["yahooTech", "qiita", "yahooInterNational", "yahooEconomy"]
        
        // 記事を表示するViewControllerをインスタンス化
        for articleView in articleViews {
            if let ArticleView = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
                
                if articleView == "yahooTech" {
                    ArticleView.sectionTitles = [Const.TECHTITLE]
                    ArticleView.tabBarItem.title = Const.TECHTITLE
                    ArticleView.feedURL = URL(string: Const.TECH)
                    
                } else if articleView == "qiita" {
                    ArticleView.sectionTitles = [Const.QIITATITLE]
                    ArticleView.tabBarItem.title = Const.QIITATITLE
                    ArticleView.feedLink = Const.QIITA
                    ArticleView.isJson = true
                    
                } else if articleView == "yahooInterNational" {
                    ArticleView.sectionTitles = [Const.INTERNATIONALTITLE]
                    ArticleView.tabBarItem.title = Const.INTERNATIONALTITLE
                    ArticleView.feedURL = URL(string: Const.INTERNATIONAL)
                    
                } else if articleView ==  "yahooEconomy" {
                    ArticleView.sectionTitles = [Const.ECONOMYTITLE]
                    ArticleView.tabBarItem.title = Const.ECONOMYTITLE
                    ArticleView.feedURL = URL(string: Const.ECONOMY)
                }
                viewControllers.append(ArticleView)
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
