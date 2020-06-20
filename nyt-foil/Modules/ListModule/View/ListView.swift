//
//  ListView.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    
    func didSelectPeriod(_ period: Int)
    
}

class ListView: UIView {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let edge: CGFloat = 8.0
        
        enum PeriodControl {
            static let height: CGFloat = 40.0
        }
    }
    
    lazy var periodControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1 day", "7 days", "30 days"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = .black
        segmentedControl.addTarget(self, action: #selector(periodChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 208
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInset = UIEdgeInsets(top: -32.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        return tableView
    }()
    
    weak var delegate: ListViewDelegate?
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        addSubview(periodControl)
        setupPeriodControlConstraints()
        addSubview(tableView)
        setupTableViewConstraints()
    }
    
    private func setupPeriodControlConstraints() {
        NSLayoutConstraint.activate([
            periodControl.topAnchor.constraint(equalTo: topAnchor, constant: Constants.edge),
            periodControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
            periodControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
            periodControl.heightAnchor.constraint(equalToConstant: Constants.PeriodControl.height)
        ])
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: periodControl.bottomAnchor, constant: Constants.edge),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Constants.edge * 2)),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (Constants.edge * 2)),
        ])
    }
    
    @IBAction private func periodChanged(_ sender: UISegmentedControl) {
        var period = 1
        switch sender.selectedSegmentIndex {
        case 0:
            period = 1
        case 1:
            period = 7
        case 2:
            period = 30
        default:
            return
        }
        delegate?.didSelectPeriod(period)
    }
    
}
