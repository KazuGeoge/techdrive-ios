//
//  JsonEncoder.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/28.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DecodedJsonData {
    func setJsonData(decodedCellTitle: [String], decodedCellLink: [String])
}

class ReadJson:NSObject, JsonsLink {

    var content: BaseContent?
    var contentList: [BaseContent] = []
    var decodedJsonData: DecodedJsonData?
    var cellTitle: [String] = []
    var cellLink: [String] = []
    
    func loadAPI(link: String) {
        let URL:String = link
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let content = BaseContent(json: json)
                        self.contentList.append(content)
                        self.cellTitle.append(content.title!)
                        self.cellLink.append(content.link!)
                        self.decodedJsonData?.setJsonData(decodedCellTitle: self.cellTitle, decodedCellLink: self.cellLink)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
