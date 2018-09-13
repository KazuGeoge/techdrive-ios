//
//  Content.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/13.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import Foundation
import SwiftyJSON

class Content : BaseContent {
    override init(title: String, url: String) {
        super.init(title: title, url: url)
    }
    
    static func getContent(json: JSON) -> Content {
        let content = Content(title: "\(json["title"])",  url: "\(json["url"])")
        
        return content
    }
}
