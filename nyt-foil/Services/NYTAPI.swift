//
//  NYTAPI.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 17/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import Moya

enum NYTAPI {
    
    case emailed(period: Int)
    case shared(period: Int)
    case viewed(period: Int)
    
}

extension NYTAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Environment.current.apiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .emailed(let period):
            return "svc/mostpopular/v2/emailed/\(period).json"
        case .shared(let period):
            return "svc/mostpopular/v2/shared/\(period).json"
        case .viewed(let period):
            return "svc/mostpopular/v2/viewed/\(period).json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return MockResponse().data(json: "articles")
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api-key" : Environment.current.apiKey], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
