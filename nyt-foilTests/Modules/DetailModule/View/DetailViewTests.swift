//
//  DetailViewTests.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 22/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import NYT

class DetailViewTests: XCTestCase {
    
    var detailView: DetailView!

    override func setUpWithError() throws {
        detailView = DetailView()
    }

    override func tearDownWithError() throws {
        detailView = nil
        try super.tearDownWithError()
    }

    func testWebView() throws {
        XCTAssertNotNil(detailView.webView)
    }

}
