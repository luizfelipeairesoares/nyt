//
//  NYTMediaMetadata.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct NYTMediaMetadata: Decodable {
    
    let url: String
    let format: String
    let height: Int
    let width: Int
    
}
