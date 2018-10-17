//
//  TabsViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/11.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var viewControlleras: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //各ViewControllerを配列にセット
        viewControlleras.append(ArticleView.yahooTech.instantiateViewController(storyboard: mainStoryboard))
        viewControlleras.append(ArticleView.qiita.instantiateViewController(storyboard: mainStoryboard))
        viewControlleras.append(ArticleView.yahooInterNational.instantiateViewController(storyboard: mainStoryboard))
        viewControlleras.append(ArticleView.yahooEconomy.instantiateViewController(storyboard: mainStoryboard))
        viewControlleras.append(ArticleView.searchVC.instantiateViewController(storyboard: mainStoryboard))
        // ページをセット
        setViewControllers(viewControlleras, animated: false)
    }
    
    // 各ViewControllerの内容を列挙
    enum ArticleView {
        case yahooTech
        case qiita
        case yahooInterNational
        case yahooEconomy
        case searchVC
        
        func instantiateViewController(storyboard: UIStoryboard) -> UIViewController {
            let errorPage = storyboard.instantiateViewController(withIdentifier: "error")
            if let articleView = storyboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {

                switch self {
                    
                //記事のViewControllerをインスタンス化
                case .yahooTech:
                    articleView.sectionTitles = [Const.TECH_TITLE]
                    articleView.tabBarItem.title = Const.TECH_TITLE
                    articleView.feedURL = URL(string: Const.TECH)
                    return articleView
                    
                case .qiita:
                    articleView.sectionTitles = [Const.QIITA_TITLE]
                    articleView.tabBarItem.title = Const.QIITA_TITLE
                    articleView.feedLink = Const.QIITA
                    articleView.isJson = true
                    return articleView
                    
                case .yahooInterNational:
                    articleView.sectionTitles = [Const.INTERNATIONAL_TITLE]
                    articleView.tabBarItem.title = Const.INTERNATIONAL_TITLE
                    articleView.feedURL = URL(string: Const.INTERNATIONAL)
                    return articleView
                    
                case .yahooEconomy:
                    articleView.sectionTitles = [Const.ECONOMY_TITLE]
                    articleView.tabBarItem.title = Const.ECONOMY_TITLE
                    articleView.feedURL = URL(string: Const.ECONOMY)
                    return articleView
                    
                // 検索のViewControllerをインスタンス化
                case .searchVC:
                    if let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchView") as? SearchViewController {
                        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
                        return searchVC
                    }
                }
            }
            return errorPage
        }
    }
}
