//
//  ArticlesService.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

protocol ArticlesServiceProtocol: BaseService {
    
    func requestArticles(completion: @escaping (Result<NYTAPIResponse, NYTAPIError>) -> Void)
    
}

struct ArticlesService: ArticlesServiceProtocol {
    
    func requestArticles(completion: @escaping (Result<NYTAPIResponse, NYTAPIError>) -> Void) {
        request(.viewed) { (result: Result<NYTAPIResponse, NYTAPIError>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
