//
//  NYTMedia.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct NYTMedia: Decodable {
    
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let metadata: [NYTMediaMetadata]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication     = "approved_for_syndication"
        case metadata                   = "media-metadata"
    }
    
}
