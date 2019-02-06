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

protocol SeachProtocol {
    func setJsonData(searchedCellTitles: [String], searchedCellLinks: [String], nickNames: [String])
}

class ReadJson:NSObject, JsonsLink {

    private var cellTitles: [String] = []
    private var cellLinks: [String] = []
    private var cellNickNames: [String] = []
    var decodedJsonData: DecodedJsonData?
    var seachProtocol: SeachProtocol?
    var isSearchFlag: Bool?
   
    func loadAPI(link: String) {
        Alamofire.request(link, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
               
                self.cellTitles = []
                self.cellLinks = []
                self.cellNickNames = []
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                     if self.isSearchFlag == true {
                   
                        json["events"].forEach { (_, json) in
                            let content = BaseContent(json: json)
                            self.cellTitles.append(content.eventTitle ?? "")
                            self.cellLinks.append(content.eventLink ?? "")
                            self.cellNickNames.append(content.nickName ?? "")
                        }
                     } else {
                        json.forEach { (_, json) in
                            let content = BaseContent(json: json)
                            self.cellTitles.append(content.title ?? "")
                            self.cellLinks.append(content.link ?? "")
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.decodedJsonData?.setJsonData(decodedCellTitles: self.cellTitles, decodedCellLinks: self.cellLinks)
            self.seachProtocol?.setJsonData(searchedCellTitles: self.cellTitles, searchedCellLinks: self.cellLinks, nickNames: self.cellNickNames)
        }
    }
}
