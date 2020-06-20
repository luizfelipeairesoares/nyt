//
//  NYTArticle.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct NYTArticle: Decodable {
    
    let uri: String
    let url: String
    let id: Int
    let source: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String
    let nytdsection: String
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let media: [NYTMedia]
    
    var photos: [NYTMedia] {
        return media.filter({ $0.subtype == "photo" })
    }
    
    private enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case source
        case publishedDate  = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case byline
        case type
        case title
        case abstract
        case media
    }
}
