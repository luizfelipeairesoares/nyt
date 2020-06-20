//
//  NYTMediaMetadata.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum NYTMediaMetadataSize: Equatable {
    
    case standard
    case double
    case triple
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.standard, .standard):
            return true
        case (.double, .double):
            return true
        case (.triple, .triple):
            return true
        default:
            return false
        }
    }
    
}

struct NYTMediaMetadata: Decodable {
    
    let url: String
    let format: String
    let height: Int
    let width: Int
    
    var size: NYTMediaMetadataSize {
        switch format {
        case "Standard Thumbnail":
            return .standard
        case "mediumThreeByTwo210":
            return .double
        case "mediumThreeByTwo440":
            return .triple
        default:
            return .standard
        }
    }
    
}
