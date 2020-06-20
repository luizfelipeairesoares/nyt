//
//  ListViewController.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

enum ListViewType {
    
    case emailed
    case viewed
    case shared
    
}

protocol ListViewProtocol: ViewControllerProtocol {
    
    init(with type: ListViewType)
    
}

class ListViewController: UIViewController, ListViewProtocol {
    
    // MARK: - Private Properties
    
    private lazy var mainView: ListView = {
        let view = ListView()
        view.delegate = self
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    private let viewType: ListViewType
    
    private var articles: [NYTArticle] = []
    
    // MARK: - Init
    
    required init(with type: ListViewType) {
        viewType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Functions
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        switch viewType {
        case .emailed:
            title = "Emailed"
        case .shared:
            title = "Shared"
        case .viewed:
            title = "Viewed"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestArticles()
    }
    
    // MARK: - Protocol Functions
    
    func reloadData() {
        stopAnimating()
        mainView.tableView.reloadData()
        mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
        mainView.tableView.isHidden = false
    }
    
    // MARK: - Private Functions
    
    private func requestArticles(for period: Int = 7) {
        mainView.tableView.isHidden = true
        showLoading()
        ArticlesService().requestArticles(for: viewType, with: period) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.articles.removeAll()
                self?.articles.append(contentsOf: response.results)
                self?.reloadData()
            case .failure(let error):
                self?.showError(with: error.localizedDescription, actionButtonTitle: "Retry", actionHandler: { [weak self] in
                    self?.requestArticles()
                })
            }
        }
    }

}

// MARK: - ListViewDelegate

extension ListViewController: ListViewDelegate {
    
    func didSelectPeriod(_ period: Int) {
        requestArticles(for: period)
    }
    
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.configureCell(object: articles[indexPath.section])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
}
