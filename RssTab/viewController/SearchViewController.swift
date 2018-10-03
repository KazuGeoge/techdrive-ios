//
//  SearchViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/10/01.
//  Copyright © 2018 城島一輝. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, DecodedJsonData, TableProtocol, XMLParserDelegate, ParsedXMLData{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private var resultTitles: [String] = []
    private var resultLinks: [String] = []
    private var searchWord: String?
    private let overlapTableView = UIView()
    private var XMLsConstList = [Const.ECONOMY, Const.TECH, Const.INTERNATIONAL]
    private var webViewDetailVC: WebViewDetailViewController = WebViewDetailViewController()
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
    var readXML: ReadXML = ReadXML()
    var readJson: ReadJson = ReadJson()
    var decodedJsonData: DecodedJsonData?
    var jsonsLink: JsonsLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureOverlapTableView()
    }
   
    // 検索バーを設定
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsSearchResultsButton = false
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "ここに入力して下さい"
        searchBar.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.darkGray
    }
    // TableViewを設定
    private func configureTableView() {
        tableViewDataSouce.tableDelegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = tableViewDataSouce
        tableView.delegate = tableViewDataSouce
    }
    // Searchバー選択時に、画面タップで戻れるようにするOverlapViewを作成
     private func configureOverlapTableView() {
        overlapTableView.backgroundColor = UIColor.black
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(overlapTableViewOnTap))
        overlapTableView.addGestureRecognizer(recognizer)
        tableViewDataSouce.isFromSearchView = true
    }
    
    // OverlapView選択時の実装
    @objc func overlapTableViewOnTap(_ button: UIButton) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    // 検索ワードを格納
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchText
    }
    // Searchバー選択時にキャンセルボタン、Viewの高さと色の設定
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.setShowsCancelButton(true, animated: true)
        
        let searchBarBottomY = searchBar.frame.origin.y + searchBar.bounds.height - tableView.contentOffset.y
        overlapTableView.frame = CGRect(x: 0, y: searchBarBottomY, width: view.bounds.height, height: view.bounds.height - searchBarBottomY)
        view.addSubview(overlapTableView)
        // 色の変化のアニメーションを設定
        overlapTableView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.overlapTableView.alpha = 0.5
        }
        return true
    }
    // Searchバー終了時に、Viewの高さと色の設定
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate(withDuration: 0.2, animations: {
            self.overlapTableView.alpha = 0
        } ) {
            _ in
            self.overlapTableView.removeFromSuperview()
        }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
    }
    // APIを飛ばし配列に格納した後、検索ワードを部分一致で抽出する
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        configureTableView()
        searchBar.text = ""
        readJson.decodedJsonData = self
        readXML.parsedXMLData = self
        
        for link in XMLsConstList {
            let constURL = URL(string: link)
            let parser:XMLParser? = XMLParser(contentsOf: constURL!)
            parser?.delegate = readXML
            parser?.parse()
        }
        readXML.cellTitles = []
        readXML.cellLinks = []
        jsonsLink = readJson
        jsonsLink?.loadAPI(link: Const.QIITA)
        tableView.reloadData()
        view.endEditing(true)
    }
    // ParseしたXMLのデータをセット
    func setXMLData(parsedCellTitles: [String], parsedCellURLs: [String]) {
        resultTitles = parsedCellTitles
        resultLinks = parsedCellURLs
    }
    // DecodeしたJsonのデータをセットした後TableViewをReloadする
    func setJsonData(decodedCellTitles: [String], decodedCellLinks: [String]) {
        var arraysSubscript = 0
        tableViewDataSouce.searchResultTitle.removeAll()
        tableViewDataSouce.searchResultLinks.removeAll()

        resultTitles += decodedCellTitles
        resultLinks += decodedCellLinks
        tableViewDataSouce.searchSection = ["検索結果"]

        for title in resultTitles {
            if title.lowercased().contains(searchWord!) {
                tableViewDataSouce.searchResultTitle.append(title)
                tableViewDataSouce.searchResultLinks.append(resultLinks[arraysSubscript])
            }
            arraysSubscript += 1
        }
        tableView.reloadData()
        resultTitles.removeAll()
        resultLinks.removeAll()
    }
    // webViewに遷移
    func pushViewController(webView: UIViewController) {
        navigationController?.pushViewController(webView, animated: true)
    }
}
