//
//  BaseContent.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/13.
//  Copyright © 2018年 城島一輝. All rights reserved.

// jsonをinitで受け入れが出来ない
import SwiftyJSON

struct BaseContent {
    var title :  String?
    var link : String?
    var imageUrlString: String?
    
    init(title: String, link: String, imageUrlString: String) {
        self.title = title
        self.link = link
        self.imageUrlString = imageUrlString
    }
    
    init(json: JSON) {
        self.title = json["title"].string
        self.link = json["url"].string
        self.imageUrlString = json["user"]["profile_image_url"].string
    }
}
