//
//  NYTAPIResponse.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct NYTAPIResponse: Decodable {
    
    let status: String
    let copyright: String
    let resultsCount: Int
    let results: [NYTArticle]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case resultsCount   = "num_results"
        case results
    }
    
}
