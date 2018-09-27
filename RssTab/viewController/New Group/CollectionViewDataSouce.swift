//
//  CollectionViewDataSouce.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/26.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class CollectionViewDataSouce: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // ステータスバーの高さ
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    // セル再利用のための固有名
    let cellId = "itemCell"
    var imageList : [String] = []
    var cellTitle: [String] = []
    var cellLink: [String] = []
    let cellWidth : CGFloat = (UIScreen.main.bounds.width - (15)) / 2
    var delegate: TableProtocol?
    let defaultMargin: CGFloat = 5
    
    // 表示するアイテムの数を設定（UICollectionViewDataSource が必要）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    // アイテムの大きさを設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // アイテム表示領域全体の上下左右の余白を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let insetMargin : CGFloat = 0.0
        return UIEdgeInsets(top: insetMargin, left: insetMargin, bottom: insetMargin, right: defaultMargin)
    }
    
    // アイテムの上下の余白の最小値を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    // アイテムの表示内容（UICollectionViewDataSource が必要）
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // アイテムを作成
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        let imageViewHeight = cellWidth + 10
        let imageViewWidth = cellWidth - defaultMargin
        
        let imageView = UIImageView(frame: CGRect(x: defaultMargin, y: 0, width: imageViewWidth, height: imageViewHeight))
        let imageLink = imageList[indexPath.row]
        let imageURL = URL(string: imageLink)
        print("imageURL:imageURL\(imageURL!)")
        imageView.sd_setImage(with: imageURL)
        cell.contentView.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRect(x: defaultMargin, y: imageViewHeight, width: imageViewWidth, height: imageViewHeight * 0.4))
        titleLabel.text = "\(cellTitle[indexPath.row])"
        titleLabel.numberOfLines = 4
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "YuGothicUI-Bold", size: 16)
        cell.contentView.addSubview(titleLabel)
        
        return cell
    }
    
    // アイテムタッチ時の処理（UICollectionViewDelegate が必要）
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "WebViewDetailView") as? WebViewDetailViewController {
            let feedItem = self.cellLink[indexPath.row]
            webViewDetailVC.webURL = URL(string: feedItem)
            let title = self.cellTitle[indexPath.row]
            webViewDetailVC.barTitle = title
            delegate?.pushWebVC(webView: webViewDetailVC)
            print("記事URL:\(feedItem)")
        }
    }
}
