//
//  SearchViewController.swift
//  RssTab
//
//  Created by 城島一輝 on 2018/10/01.
//  Copyright © 2018 城島一輝. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, TableProtocol, SeachProtocol {
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private var searchWord: String?
    private let overlapTableView = UIView()
    private var webViewDetailVC: WebViewDetailViewController = WebViewDetailViewController()
    var tableViewDataSouce: TableViewDataSouce = TableViewDataSouce()
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
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
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
    
    // Searchバー終了時のViewの高さと色の設定
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
    
    // APIを飛ばし、検索ワードを抽出する
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        configureTableView()
        searchBar.text = ""
        readJson.seachProtocol = self
        readJson.isSearchFlag = true
        jsonsLink = readJson
        let encodedString : String = searchWord!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        jsonsLink?.loadAPI(link: Const.ATND_BASE_LINK + encodedString + Const.ASSIGN_FORMAT)
        tableView.reloadData()
        view.endEditing(true)
    }
   
    // DecodeしたJsonのデータをセットした後TableViewをReloadする
    func setJsonData(searchedCellTitles: [String], searchedCellLinks: [String], nickNames: [String]) {
        tableViewDataSouce.searchResultTitles = searchedCellTitles
        tableViewDataSouce.searchResultLinks = searchedCellLinks
        tableViewDataSouce.nickNames = nickNames
        tableViewDataSouce.searchSection = ["検索結果"]
        tableView.reloadData()
    }
    
    // webViewに遷移
    func pushViewController(webView: UIViewController) {
        navigationController?.pushViewController(webView, animated: true)
    }
}
