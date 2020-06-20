//
//  DetailViewController.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import WebKit

protocol DetailViewControllerProtocol: ViewControllerProtocol {
    
    init(with article: NYTArticle)
    
}

class DetailViewController: UIViewController, DetailViewControllerProtocol {

    // MARK: - Private Properties
    
    private lazy var mainView: DetailView = {
        let view = DetailView()
        view.webView.navigationDelegate = self
        return view
    }()
    
    private let article: NYTArticle
    
    // MARK: - Init
    
    required init(with article: NYTArticle) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = article.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = URL(string: article.url) else {
            return
        }
        
        showLoading()
        mainView.webView.load(URLRequest(url: url))
    }
    
    // MARK: - ViewControllerProtocol functions
    
    func reloadData() { }

}

// MARK: - WKNavigationDelegate

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(with: error.localizedDescription, actionButtonTitle: nil, actionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url, url.absoluteString == article.url else {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
}
