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
        
        if let yahooTechVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
            yahooTechVC.sectionTitle = ["IT 科学"]
            yahooTechVC.feedURL = URL(string: Const.TECH)
            yahooTechVC.isXML = true
        
            if let qiitaVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
                qiitaVC.sectionTitle = ["キータ一覧"]
                qiitaVC.feedLink = Const.QIITA
        
                if let yahooInternational = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
                    yahooInternational.sectionTitle = ["国際ニュース"]
                    yahooInternational.feedURL = URL(string: Const.INTERNATIONAL)
                    yahooInternational.isXML = true
        
                    if let yahooEconomyVC = mainStoryboard.instantiateViewController(withIdentifier: "ArticleView") as? ArticleViewController {
                        yahooEconomyVC.sectionTitle = ["経済ニュース"]
                        yahooEconomyVC.feedURL = URL(string: Const.ECONOMY)
                        yahooEconomyVC.isXML = true
        
                        //タイトルを設定
                        yahooTechVC.tabBarItem.title = "IT 科学ニュース"
                        qiitaVC.tabBarItem.title = "キータ一覧"
                        yahooInternational.tabBarItem.title = "国際ニュース"
                        yahooEconomyVC.tabBarItem.title = "経済ニュース"
                        
                        let viewControllers = [yahooTechVC, qiitaVC, yahooInternational, yahooEconomyVC]
                        // ページをセット
                        self.setViewControllers(viewControllers, animated: false)
                    }
                }
            }
        }
    }
}
