//
//  ArticlesServiceTests.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
@testable import NYT

class ArticlesServiceTests: XCTestCase {
    
    var service: ArticlesService!

    override func setUpWithError() throws {
        service = ArticlesService(with: MoyaProvider<NYTAPI>(stubClosure: MoyaProvider.delayedStub(2)))
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func testSuccess() throws {
        var success = false
        let expectation = self.expectation(description: "request")
        service.requestArticles(for: .emailed, with: 7) { (result) in
            switch result {
            case .success:
                success = true
            case .failure:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(success)
    }

}
