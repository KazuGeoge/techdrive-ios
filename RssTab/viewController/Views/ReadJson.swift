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
    func setJsonData(searchedCellTitle: [String], searchedCellLink: [String], nickName: [String])
}

class ReadJson:NSObject, JsonsLink {

    private var cellTitles: [String] = []
    private var cellLinks: [String] = []
    private var content: BaseContent?
    private var cellnikNames: [String] = []
    var decodedJsonData: DecodedJsonData?
    var seachProtocol: SeachProtocol?
    var isSearchFlag: Bool?
   
    func loadAPI(link: String) {
        let URL:String = link
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
               
                self.cellTitles = []
                self.cellLinks = []
                self.cellnikNames = []
                
                if let value = response.result.value {
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let content = BaseContent(json: json)
                        print("eventsTitle:\(json[]["events"][0]["event"]["title"].string!)")
                        
                        if self.isSearchFlag == true {
                            self.cellTitles.append(content.eventTitle ?? "")
                            self.cellLinks.append(content.eventLink ?? "")
                            self.cellnikNames.append(content.nickName ?? "")
                        } else {
                            self.cellTitles.append(content.title ?? "")
                            self.cellLinks.append(content.link ?? "")
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
            self.decodedJsonData?.setJsonData(decodedCellTitles: self.cellTitles, decodedCellLinks: self.cellLinks)
            self.seachProtocol?.setJsonData(searchedCellTitle: self.cellTitles, searchedCellLink: self.cellLinks, nickName: self.cellnikNames)
        }
    }
}
