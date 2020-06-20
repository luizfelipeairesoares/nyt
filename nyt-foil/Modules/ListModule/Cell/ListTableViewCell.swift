//
//  ListTableViewCell.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell, CellProtocol {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let edge: CGFloat = 8.0
        
        enum LabelNumber {
            static let height: CGFloat = 32.0
            static let fontSize: CGFloat = 16.0
        }
        
        enum LabelAbstract {
            static let fontSize: CGFloat = 16.0
        }
        
        enum ImgView {
            static let width: CGFloat = 440
            static let height: CGFloat = 293
        }
    }
    
    private lazy var labelNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.LabelNumber.fontSize)
        return label
    }()
    
    private lazy var labelAbstract: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.LabelAbstract.fontSize)
        return label
    }()
    
    private lazy var imgView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Cell Protocol
    
    typealias T = NYTArticle
    
    func configureCell(object: NYTArticle) {
        labelNumber.text = object.section + " " + object.subsection
        labelAbstract.text = object.abstract
    }
    
    // MARK: - Private Functions
    
    private func setupSubviews() {
        contentView.addSubview(labelNumber)
        setupLabelNumberConstraints()
        
        contentView.addSubview(imgView)
        setupImgViewConstraints()
        
        contentView.addSubview(labelAbstract)
        setupLabelAbstractConstraints()
    }
    
    private func setupLabelNumberConstraints() {
        NSLayoutConstraint.activate([
            labelNumber.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.edge),
            labelNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.edge),
            labelNumber.heightAnchor.constraint(equalToConstant: Constants.LabelNumber.height)
        ])
    }
    
    private func setupLabelAbstractConstraints() {
        NSLayoutConstraint.activate([
            labelAbstract.topAnchor.constraint(equalTo: labelNumber.bottomAnchor, constant: Constants.edge),
            labelAbstract.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.edge),
            labelAbstract.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -Constants.edge),
            labelAbstract.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.edge)
        ])
    }
    
    private func setupImgViewConstraints() {
        NSLayoutConstraint.activate([
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(Constants.edge * 2)),
            imgView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imgView.widthAnchor.constraint(equalToConstant: Constants.ImgView.width),
            imgView.heightAnchor.constraint(equalToConstant: Constants.ImgView.height)
        ])
    }

}
