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

protocol ListViewProtocol: AnyObject {
    
    init(with type: ListViewType)
    
}

class ListViewController: UIViewController, ListViewProtocol {
    
    // MARK: - Private Properties
    
    private lazy var mainView: ListView = {
        let view = ListView()
        view.tableView.dataSource = self
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
    
    // MARK: - Private Functions
    
    private func requestArticles() {
        ArticlesService().requestArticles { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.articles.append(contentsOf: response.results)
                self?.mainView.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

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
