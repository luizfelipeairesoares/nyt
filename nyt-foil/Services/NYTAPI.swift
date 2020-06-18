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
    
    case emailed
    case shared
    case viewed
    
}

extension NYTAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nytimes.com/")!
    }
    
    var path: String {
        switch self {
        case .emailed:
            return "svc/mostpopular/v2/emailed/7.json"
        case .shared:
            return "svc/mostpopular/v2/shared/7.json"
        case .viewed:
            return "svc/mostpopular/v2/viewed/7.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api-key" : "b3Iu2hNzuB9SuYej96r9fNZ3hwXxKuSj"], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
