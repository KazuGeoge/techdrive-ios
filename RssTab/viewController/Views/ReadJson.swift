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
    func setJsonData(decodedCellTitles: [String], decodedCellLinks: [String])
}

class ReadJson:NSObject, JsonsLink {

    private var cellTitles: [String] = []
    private var cellLinks: [String] = []
    private var contentLists: [BaseContent] = []
    private var content: BaseContent?
    var decodedJsonData: DecodedJsonData?
    var isSearchFlag: Bool?
   
    func loadAPI(link: String) {
        let URL:String = link
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                self.contentLists = []
                self.cellTitles = []
                self.cellLinks = []
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let content = BaseContent(json: json)
                        self.contentLists.append(content)
                        self.cellTitles.append(content.title ?? "")
                        self.cellLinks.append(content.link ?? "")
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.decodedJsonData?.setJsonData(decodedCellTitles: self.cellTitles, decodedCellLinks: self.cellLinks)
        }
    }
}
