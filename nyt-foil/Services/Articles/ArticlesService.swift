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
    
    func requestArticles(for viewType: ListViewType, with period: Int, completion: @escaping (Result<NYTAPIResponse, NYTAPIError>) -> Void)
    
}

struct ArticlesService: ArticlesServiceProtocol {
    
    var provider: MoyaProvider<NYTAPI>
    
    init(with provider: MoyaProvider<NYTAPI> = MoyaProvider<NYTAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.provider = provider
    }
    
    func requestArticles(for viewType: ListViewType, with period: Int, completion: @escaping (Result<NYTAPIResponse, NYTAPIError>) -> Void) {
        var target: NYTAPI = .viewed(period: period)
        switch viewType {
        case .emailed:
            target = .emailed(period: period)
        case .shared:
            target = .shared(period: period)
        case .viewed:
            target = .viewed(period: period)
        }
        request(target) { (result: Result<NYTAPIResponse, NYTAPIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
