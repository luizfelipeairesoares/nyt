//
//  CellProtocol.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol CellProtocol {
    
    associatedtype T: Decodable
    
    func configureCell(object: T)
    
}
