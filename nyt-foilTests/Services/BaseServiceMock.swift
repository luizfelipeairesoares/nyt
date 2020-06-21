//
//  BaseServiceMock.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Moya
@testable import NYT

protocol BaseServiceMock: BaseServiceProtocol {
    
}

extension BaseServiceMock {
    
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
