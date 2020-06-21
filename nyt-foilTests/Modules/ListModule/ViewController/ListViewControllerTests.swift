//
//  ListViewControllerTests.swift
//  nyt-foilTests
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
import Moya
@testable import NYT

class ArticlesServiceMock: ArticlesServiceProtocol {
    
    var provider: MoyaProvider<NYTAPI>
    
    var expectedResult: Result<NYTAPIResponse, NYTAPIError>! //= .success(NYTAPIResponse(status: "", copyright: "", resultsCount: 0, results: []))
    
    required init(with provider: MoyaProvider<NYTAPI>) {
        self.provider = provider
    }
    
    func requestArticles(for viewType: ListViewType, with period: Int, completion: @escaping (Result<NYTAPIResponse, NYTAPIError>) -> Void) {
        completion(expectedResult)
    }
    
}

class ListViewControllerTests: XCTestCase {
    
    var mockService: ArticlesServiceMock!
    var viewController: ListViewControllerProtocol!

    override func setUpWithError() throws {
        mockService = ArticlesServiceMock(with: MoyaProvider<NYTAPI>(stubClosure: MoyaProvider.immediatelyStub))
        viewController = ListViewController(with: .emailed, service: mockService)
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }

    func testView() throws {
        XCTAssertTrue((viewController as! ListViewController).view is ListView)
    }
    
    func testSuccessRequest() throws {
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
        mockService.expectedResult = .success(NYTAPIResponse(status: "", copyright: "", resultsCount: 1, results: [article]))
        
        (viewController as! ListViewController).viewWillAppear(false)
        
        XCTAssertFalse(viewController.articles.isEmpty)
    }
    
    func testFailureRequest() throws {
        mockService.expectedResult = .failure(NYTAPIError.unauthorized)
        
        (viewController as! ListViewController).viewWillAppear(false)
        
        XCTAssertTrue(viewController.articles.isEmpty)
    }
    
    func testTableViewSelect() throws {
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
        
        let controller = (viewController as! ListViewController)
        controller.articles = [article]
        
        let navController = UINavigationController(rootViewController: controller)
        
        let view = (controller.view as! ListView)
        
        let tableView = view.tableView
        
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        _ = expectation(for: NSPredicate(block: { (_, _) -> Bool in
            navController.topViewController is DetailViewController
        }), evaluatedWith: navController, handler: .none)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertNotNil(navController.topViewController as? DetailViewController)
    }

}
