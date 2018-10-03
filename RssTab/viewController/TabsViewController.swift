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
        
        // 記事を表示するViewControllerをインスタンス化
        if let yahooTechVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
            yahooTechVC.sectionTitles = [Const.TECHTITLE]
            yahooTechVC.tabBarItem.title = Const.TECHTITLE
            yahooTechVC.feedURL = URL(string: Const.TECH)
            yahooTechVC.isXML = true
            viewControllers.append(yahooTechVC)
        }
        
        if let qiitaVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
            qiitaVC.sectionTitles = [Const.QIITATITLE]
            qiitaVC.tabBarItem.title = Const.QIITATITLE
            qiitaVC.feedLink = Const.QIITA
            viewControllers.append(qiitaVC)
        }
        
        if let yahooInternational = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
            yahooInternational.sectionTitles = [Const.INTERNATIONALTITLE]
            yahooInternational.tabBarItem.title = Const.INTERNATIONALTITLE
            yahooInternational.feedURL = URL(string: Const.INTERNATIONAL)
            yahooInternational.isXML = true
            viewControllers.append(yahooInternational)
        }
        
        if let yahooEconomyVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
            yahooEconomyVC.sectionTitles = [Const.ECONOMYTITLE]
            yahooEconomyVC.tabBarItem.title = Const.ECONOMYTITLE
            yahooEconomyVC.feedURL = URL(string: Const.ECONOMY)
            yahooEconomyVC.isXML = true
            viewControllers.append(yahooEconomyVC)
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
