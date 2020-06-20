//
//  DetailView.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import WebKit

class DetailView: UIView {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let edge: CGFloat = 8.0
    }

    lazy var webView: WKWebView = {
        let web = WKWebView(frame: .zero)
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private func setupSubviews() {
        addSubview(webView)
        setupWebViewConstraints()
    }
    
    private func setupWebViewConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }

}
