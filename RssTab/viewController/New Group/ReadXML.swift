//
//  ReadXML.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/24.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol ParseProtocol {
    func configureTable(cellTtile: [String], celURL: [String])
}

protocol ParseXML {
    func parse(parsedCellTitle: [String], parsedCellURL: [String])
}

class ReadXML: NSObject, XMLParserDelegate {
    
    private let feedUrl = URL(string: Const.TECH)
    private var feedItems = [FeedItem]()
    private var currentElementName : String?
    private let itemElementName = "item"
    private let titleElementName = "title"
    private let linkElementName = "link"
    var tablePage : TableViewDataSouce = TableViewDataSouce()
    var XMLdelegate: ParseXML?
    var cellTitle : [String] = []
    var cellLink : [String] = []
    var judjeTilte : Bool? = true
    var delegate : XMLParserDelegate?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElementName = nil
        
        if elementName == itemElementName {
            self.feedItems.append(FeedItem())
        } else {
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.feedItems.count > 0 {
            var lastItem = self.feedItems[self.feedItems.count - 1]
            
            switch self.currentElementName {
                
            case titleElementName:
                if judjeTilte == true {
                    let tmpString = lastItem.title
                    lastItem.title = tmpString + string
                    cellTitle.append(lastItem.title)
                    tablePage.cellTitle = cellTitle
                    print("firstCellTitle:\(lastItem.title)")
                    judjeTilte = false
                } else {
                    let tmpString = lastItem.title
                    lastItem.title = tmpString + string
                    let lastCelltitle = cellTitle.last!
                    let BondCellTitle = lastCelltitle + lastItem.title
                    cellTitle.removeLast()
                    cellTitle.append(BondCellTitle)
                    tablePage.cellTitle = cellTitle
                }
                
            case linkElementName:
                if judjeTilte == false {
                    lastItem.link = string
                    cellLink.append(lastItem.link)
                    tablePage.cellLink = cellLink
                    print("firstCellURL:\(lastItem.link)")
                    judjeTilte = true
                }
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
        XMLdelegate?.parse(parsedCellTitle: cellTitle, parsedCellURL: cellLink)
    }
}
