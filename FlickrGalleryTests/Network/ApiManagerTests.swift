//
//  ApiManagerTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/20/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery
class ApiManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_FeedUrl_IsGeneratedCorrectly_When_Query_IsPassed() {
        let feedUrl = ApiManager.sharedInstance.getFeedUrlStringFor(query: "Bird")
        let finalUrl = "\(ApiManager.sharedInstance.endPoint)&tags=Bird"
        XCTAssertEqual(feedUrl, finalUrl)
    }

    func test_FeedUrl_DoesNotInclude_Tags_When_Query_IsNil() {
        let feedUrl = ApiManager.sharedInstance.getFeedUrlStringFor(query:nil)
        let finalUrl = ApiManager.sharedInstance.endPoint
        XCTAssertEqual(feedUrl, finalUrl)
    }
}
