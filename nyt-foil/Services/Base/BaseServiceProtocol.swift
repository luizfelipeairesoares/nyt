//
//  BaseServiceProtocol.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

protocol BaseServiceProtocol {
    
    var provider: MoyaProvider<NYTAPI> { get }
    
    init(with provider: MoyaProvider<NYTAPI>)
    
    func request<T: Decodable>(_ target: NYTAPI, completion: @escaping (Result<T, NYTAPIError>) -> Void)
    
}
