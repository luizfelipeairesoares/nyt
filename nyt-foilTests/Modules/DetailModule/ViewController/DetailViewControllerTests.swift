//
//  DetailViewControllerTests.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import NYT

class DetailViewControllerTests: XCTestCase {

    var viewController: DetailViewControllerProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }

    func testView() throws {
        let article = NYTArticle(
            uri: "",
            url: "https://www.nytimes.com/2020/06/12/us/politics/trump-transgender-rights.html",
            id: 0,
            source: "",
            publishedDate: "",
            updated: "",
            section: "",
            subsection: "",
            nytdsection: "",
            byline: "",
            type: "",
            title: "",
            abstract: "",
            media: []
        )
        viewController = DetailViewController(with: article)
        XCTAssertTrue((viewController as! DetailViewController).view is DetailView)
    }
    
    func testWebViewLoading() throws {
        let article = NYTArticle(
            uri: "",
            url: "https://www.nytimes.com/2020/06/12/us/politics/trump-transgender-rights.html",
            id: 0,
            source: "",
            publishedDate: "",
            updated: "",
            section: "",
            subsection: "",
            nytdsection: "",
            byline: "",
            type: "",
            title: "",
            abstract: "",
            media: []
        )
        viewController = DetailViewController(with: article)
        (viewController as! DetailViewController).viewWillAppear(false)
        XCTAssertTrue(((viewController as! DetailViewController).view as! DetailView).webView.isLoading)
    }
    
    func testURLError() throws {
        let article = NYTArticle(
            uri: "",
            url: "",
            id: 0,
            source: "",
            publishedDate: "",
            updated: "",
            section: "",
            subsection: "",
            nytdsection: "",
            byline: "",
            type: "",
            title: "",
            abstract: "",
            media: []
        )
        viewController = DetailViewController(with: article)
        (viewController as! DetailViewController).viewWillAppear(false)
        XCTAssertFalse(((viewController as! DetailViewController).view as! DetailView).webView.isLoading)
        XCTAssertNotNil((viewController as! DetailViewController).presentationController)
    }

}
