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
    var image: String?
    
    init(title: String, link: String, image: String) {
        self.title = title
        self.link = link
        self.image = image
    }
    
    init(json: JSON) {
        self.title = json["title"].string
        self.link = json["url"].string
        self.image = json["user"]["profile_image_url"].string
    }
}
