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
        let firstVC = Page1ViewController()
        let secondVC = Page2ViewController()
        let thirdVC = Page3ViewController()
        let forceVC = Page4ViewController()
        let fifthVC = Page5ViewController()
        let sixVC = Page6ViewController()
        
        //タイトルを設定
        firstVC.tabBarItem.title = "IT 科学ニュース"
        secondVC.tabBarItem.title = "キータ一覧"
        thirdVC.tabBarItem.title = "国際ニュース"
        forceVC.tabBarItem.title = "経済"
        fifthVC.tabBarItem.title = "エンタメニュース"
        sixVC.tabBarItem.title = "スポーツニュース"
        let viewControllers = [firstVC, secondVC, thirdVC, forceVC, fifthVC, sixVC]
        // ページをセット
        self.setViewControllers(viewControllers, animated: false)
    }
}
