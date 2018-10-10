//
//  ListCell.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/10/09.
//  Copyright © 2018 城島一輝. All rights reserved.
//

import UIKit

// Listセルの形をここで設定
class ListCell: UITableViewCell {

    var title = UILabel()
    var nickName = UILabel()
    let cellHeight: CGFloat = 70
    let cellMargin: CGFloat = 10
    let titleFontSize: CGFloat = 17
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(cellTitle: String, cellNickname: String) {
        let titleY = cellHeight / 2 - titleFontSize + 5
        title.frame = CGRect(x: cellMargin, y: titleY, width:  UIScreen.main.bounds.size.width - cellMargin, height: cellHeight * 2 / 3)
        title.font = UIFont(name:"YuGothicUI-Bold", size: titleFontSize)
        title.textColor = UIColor.black
        title.text = cellTitle
        title.sizeToFit()
        self.contentView.addSubview(title)
        
        nickName.frame = CGRect(x: cellMargin, y: titleY - 5 + titleFontSize + 15, width: UIScreen.main.bounds.size.width - cellMargin, height: cellHeight / 3)
        nickName.font = UIFont.systemFont(ofSize: 12)
        nickName.textColor = UIColor.gray
        nickName.text = cellNickname
        self.contentView.addSubview(nickName)
    }
}
