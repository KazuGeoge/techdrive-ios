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
        
        // ViewControllerをインスタンス化
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let yahooTechVC = mainStoryboard.instantiateViewController(withIdentifier: "YahooTechArticle") as! YahooTechArticleViewController
        let qiitaVC = mainStoryboard.instantiateViewController(withIdentifier: "QiitaArticle") as! QiitaArticleViewController
        let yahooInternationalVC = mainStoryboard.instantiateViewController(withIdentifier: "YahooInternationalArticle") as! YahooInternationalArticleViewController
        let yahooEconomyVC = mainStoryboard.instantiateViewController(withIdentifier: "YahooEconomyArticle") as! YahooEconomyArticleViewController
        let yahooEntaVC = mainStoryboard.instantiateViewController(withIdentifier: "YahooEntaArticle") as! YahooEntaArticleViewController
        let yahooSportsVC = mainStoryboard.instantiateViewController(withIdentifier: "YahooSportsArticle") as! YahooSportsArticleViewController
        
        //タイトルを設定
        yahooTechVC.tabBarItem.title = "IT 科学ニュース"
        qiitaVC.tabBarItem.title = "キータ一覧"
        yahooInternationalVC.tabBarItem.title = "国際ニュース"
        yahooEconomyVC.tabBarItem.title = "経済"
        yahooEntaVC.tabBarItem.title = "エンタメニュース"
        yahooSportsVC.tabBarItem.title = "スポーツニュース"
        let viewControllers = [yahooTechVC, qiitaVC, yahooInternationalVC, yahooEconomyVC, yahooEntaVC, yahooSportsVC]
        // ページをセット
        self.setViewControllers(viewControllers, animated: false)
    }
}
