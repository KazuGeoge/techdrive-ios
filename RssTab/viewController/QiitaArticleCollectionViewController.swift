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

class QiitaArticleCollectionViewController: UIViewController, TableProtocol {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    // セル再利用のための固有名
    let cellId = "itemCell"
    var collection: CollectionViewDataSouce = CollectionViewDataSouce()
    var contentList: [BaseContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        loadAPI()
    }
    
    func collectionView(){
        let collectionViewInstance = UICollectionView(
            frame: CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: self.view.frame.size.height - statusBarHeight),
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewInstance.backgroundColor = UIColor.white
        collectionViewInstance.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionViewInstance.delegate = self.collection
        collectionViewInstance.dataSource = self.collection
        self.view.addSubview(collectionViewInstance)
    }
    
    private func loadAPI() {
        let URL:String = Const.QIITA
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let content = BaseContent(json: json)
                        self.contentList.append(content)
                        
                        self.collection.cellTitle.append(content.title)
                        self.collection.cellLink.append(content.link)
                        self.collection.imageList.append(content.image)
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.collectionView()
        }
    }
    
    func pushWebVC(webView: UIViewController) {
        self.navigationController?.pushViewController(webView, animated: true)
    }
}
