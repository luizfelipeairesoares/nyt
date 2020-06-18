//
//  NYTAPIError.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum NYTAPIError: Error {
    
    case unauthorized
    case jsonMapping
    
    var localizedDescription: String {
        switch self {
        case .unauthorized:
            return "Unauthorized"
        case .jsonMapping:
            return "Mapping Error"
        }
    }
    
}
