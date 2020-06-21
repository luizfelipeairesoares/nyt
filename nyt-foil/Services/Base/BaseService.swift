//
//  BaseService.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

protocol BaseService: BaseServiceProtocol {
    
}

extension BaseService {
    
    func request<T: Decodable>(_ target: NYTAPI, completion: @escaping (Result<T, NYTAPIError>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object: T = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.jsonMapping))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.unauthorized))
            }
        }
    }
    
}
