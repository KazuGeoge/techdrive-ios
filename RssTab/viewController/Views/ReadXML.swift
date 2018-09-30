//
//  ReadXML.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/09/24.
//  Copyright © 2018年 城島一輝. All rights reserved.
//

import UIKit

protocol ParsedXMLData {
    func setXMLData(parsedCellTitle: [String], parsedCellURL: [String])
}

class ReadXML: NSObject, XMLParserDelegate {
    
    private var feedItems = [FeedItem]()
    private var currentElementName: String?
    private let itemElementName = "item"
    private let titleElementName = "title"
    private let linkElementName = "link"
    private var isSplitTilte: Bool? = true
    var parsedXMLData: ParsedXMLData?
    var cellTitle: [String] = []
    var cellLink: [String] = []
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        
        if elementName == itemElementName {
            feedItems.append(FeedItem())
        } else {
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if feedItems.count > 0 {
            var lastItem = feedItems[feedItems.count - 1]
            
            switch currentElementName {
                
            case titleElementName:
                
                if isSplitTilte == true {
                    let tmpString = lastItem.title
                    lastItem.title = tmpString + string
                    cellTitle.append(lastItem.title)
                    isSplitTilte = false
                } else {
                    //マルチバイトによる分裂したタイトルを結合
                    let tmpString = lastItem.title
                    lastItem.title = tmpString + string
                    if let lastCelltitle = cellTitle.last {
                        let BondCellTitle = lastCelltitle + lastItem.title
                        cellTitle.removeLast()
                        cellTitle.append(BondCellTitle)
                    }
                }
                
            case linkElementName:
                
                if isSplitTilte == false {
                    lastItem.link = string
                    cellLink.append(lastItem.link)
                    
                    print("firstCellURL:\(lastItem.link)")
                    isSplitTilte = true
                }
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElementName = nil
        parsedXMLData?.setXMLData(parsedCellTitle: cellTitle, parsedCellURL: cellLink)
    }
}