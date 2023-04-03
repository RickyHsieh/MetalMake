//
//  HomeViewController.swift
//  MetalMake
//
//  Created by 謝佳勳 on 2023/4/2.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Popular","Heavy Metal","Power Metal","Symphonic Metal","Black Metal","Nu Metal ","Top rated"]
    
    
    private let homeFeedTable: UITableView = {
//        let table = UITableView()
        let table = UITableView(frame: .zero, style: .grouped)
        
        //register my customer cell
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        
        configureNavBar()
        
        // home header
        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)

        let barButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        barButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -100, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = barButtonItem
        
        navigationItem.rightBarButtonItems = [
            
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: nil)
            
        ]
        navigationController?.navigationBar.tintColor = .white

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Hello World"
//        cell.backgroundColor = .red
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /**
     當 tableView 即將顯示 header view 時會被調用。此方法中的參數有三個，分別為 tableView 本身、即將顯示的 header view、以及 section 的 index。此方法的作用為對即將顯示的 header view 做出一些自定義設置，例如更改字型、設定位置等。在這段程式碼中，透過 guard let 語法判斷 view 是否為 UITableViewHeaderFooterView，如果是則將其字型設為系統字型，大小為 18pt，加粗體。接著更改 header.textLabel?.frame 的值，將其 x 軸座標加上 20pt，使其從左側偏移 20pt。
     */
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
   /**
    這是一個 UITableViewDataSource 協議中的方法，用於設置表格視圖中每個區塊的標題文字。在這個方法中，通過傳入的參數 section 取得當前區塊的索引，然後從 sectionTitles 數組中獲取對應的標題文字返回。這樣就可以在表格視圖中的每個區塊頂部顯示自定義的標題了。
    */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    //當 UIScrollView 的 contentOffset 屬性發生變化時會被調用。可以在這個方法中實現根據滾動位置調整 UI 的功能。
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOfSet
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}
