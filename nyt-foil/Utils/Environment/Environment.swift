//
//  Environment.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol EnvironmentProtocol {
    
    var apiBaseURL: String { get }
    var apiKey: String { get }
    
}

struct Environment: EnvironmentProtocol {
    
    var apiBaseURL: String
    var apiKey: String
    
    static let current = Environment()
    
    // MARK: - Init
    
    init() {
        guard let infoDict = Bundle.main.infoDictionary else { fatalError() }
        guard let serverURL = infoDict["ApiServer"] as? String, let apiKey = infoDict["ApiKey"] as? String else {
            fatalError()
        }
        self.apiBaseURL = serverURL
        self.apiKey = apiKey
    }
    
}
