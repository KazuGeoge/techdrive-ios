//
//  BaseContent.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/13.
//  Copyright © 2018年 城島一輝. All rights reserved.

import SwiftyJSON

struct BaseContent {
    var title:  String?
    var link: String?
    var imageUrlString: String?
    var eventTitle: String?
    var eventLink: String?
    var nickName: String?
    
    
    init(title: String, link: String, imageUrlString: String, evaetTitle: String, event_url: String, owner_nickname: String) {
        self.title = title
        self.link = link
        self.imageUrlString = imageUrlString
        self.eventTitle = evaetTitle
        self.eventLink = event_url
        self.nickName = owner_nickname
    }
    
    init(json: JSON) {
        self.title = json["title"].string
        self.link = json["url"].string
        self.imageUrlString = json["user"]["profile_image_url"].string
        self.eventTitle = json["events"][0]["event"]["title"].string
        self.eventLink = json["events"][0]["_event"]["_event_url"].string
        self.nickName = json["events"][0]["_event"]["_owner_nickname"].string
    }
}
