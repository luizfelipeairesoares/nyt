//
//  ListViewTests.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import NYT

class SpyDelegate: ListViewDelegate {
    
    var capturedAction: Bool = false
    
    func didSelectPeriod(_ period: Int) {
        capturedAction = true
    }
    
}

class ListViewTests: XCTestCase {
    
    var listView: ListView!

    override func setUpWithError() throws {
        listView = ListView()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testProperties() throws {
        XCTAssertNotNil(listView.periodControl)
        XCTAssertNotNil(listView.tableView)
        
        XCTAssertTrue(listView.periodControl.superview is ListView)
        XCTAssertTrue(listView.tableView.superview is ListView)
    }

    func testDelegate() throws {
        let delegate = SpyDelegate()
        listView.delegate = delegate
        listView.periodChanged(listView.periodControl)
        XCTAssertTrue(delegate.capturedAction)
    }

}
