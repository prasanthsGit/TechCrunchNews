//
//  ViewController.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newsListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsListTable.separatorStyle = .none
        newsListTable.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        newsListTable.refreshControl = refreshControl
    }
    
    @objc func pullRefresh(refreshControl: UIRefreshControl) {
        print("refresh table")
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

