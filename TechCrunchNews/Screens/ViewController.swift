//
//  ViewController.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var newsListTable: UITableView!
    var newsList: [Article]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        newsListTable.separatorStyle = .none
        newsListTable.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        newsListTable.refreshControl = refreshControl
        callGetNewsList()
    }
    
    @objc func pullRefresh(refreshControl: UIRefreshControl) {
        print("refresh table")
        callGetNewsList()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.updateCell(details: newsList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = newsList?[indexPath.row].url, let controller = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            controller.link = link
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - API CALL
extension ViewController {
    func callGetNewsList() {
        startPreloader()
        APIClient.apiRequest(url: ApiConstants.baseUrl + ApiConstants.apiKey, method: HTTPMethod.get, parameter: nil) { [weak self] status, response, message, data in
            print(status, response, message, data)
            self?.stopPreloder()
            if status {
                do {
                    let response = try JSONDecoder().decode(NewsData.self, from: data)
                    self?.newsList = response.articles
                    self?.newsListTable.reloadData()
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("failed")
            }
        }
    }
}

