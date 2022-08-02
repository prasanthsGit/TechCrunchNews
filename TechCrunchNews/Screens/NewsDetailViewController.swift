//
//  NewsDetailViewController.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//
import Alamofire
import NVActivityIndicatorView
import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    @IBOutlet var bgWebView: UIView!
    var link = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        startPreloader()
        loadWebUrl(urlStr: link)
    }
    
    func loadWebUrl(urlStr: String) {
        let webView = WKWebView(frame: CGRect(x: 20, y: 0, width: bgWebView.frame.width - 40, height: bgWebView.frame.height))
        webView.navigationDelegate = self
        webView.contentMode = .scaleAspectFit
        webView.sizeToFit()
        webView.autoresizesSubviews = true
        bgWebView.addSubview(webView)
        if let link = URL(string: urlStr) {
            print("url:", link)
            let request = URLRequest(url: link)
            webView.load(request)
        }
    }
    
    @IBAction func backAction(_: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didFail _: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        stopPreloder()
    }
}
