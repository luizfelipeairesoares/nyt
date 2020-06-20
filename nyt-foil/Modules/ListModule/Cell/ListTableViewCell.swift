//
//  ListTableViewCell.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import Kingfisher

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
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: Constants.LabelAbstract.fontSize)
        return label
    }()
    
    private lazy var imgView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_thumbnail")
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = UIImage(named: "img_thumbnail")
        labelNumber.text = nil
        labelAbstract.text = nil
    }
    
    // MARK: - Cell Protocol
    
    typealias T = NYTArticle
    
    func configureCell(object: NYTArticle) {
        labelNumber.text = object.section + " " + object.subsection
        labelAbstract.text = object.abstract
        if let media = object.photos.first {
            if let photo = media.metadata.first(where: { $0.size == .triple }) {
                let processor = RoundCornerImageProcessor(cornerRadius: Constants.edge)
                imgView.kf.setImage(with: URL(string: photo.url),
                                    placeholder: UIImage(named: "img_thumbnail"),
                                    options: [.processor(processor), .transition(.fade(1))])
            }
        }
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
            labelNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelNumber.heightAnchor.constraint(equalToConstant: Constants.LabelNumber.height)
        ])
    }
    
    private func setupLabelAbstractConstraints() {
        NSLayoutConstraint.activate([
            labelAbstract.topAnchor.constraint(equalTo: labelNumber.bottomAnchor),
            labelAbstract.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelAbstract.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -Constants.edge),
            labelAbstract.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
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
