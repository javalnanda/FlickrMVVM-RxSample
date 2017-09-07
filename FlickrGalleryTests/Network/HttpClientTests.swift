//
//  HttpClientTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/20/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery
// MARK: MOCK
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?

    private (set) var lastURL: URL?

    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url

        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
}

// MARK: Test
class HttpClientTests: XCTestCase {

    var httpClient: HttpClient!
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_get_request_with_URL() {

        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }

        httpClient.get(url: url) { (_, _) in
            // Return data
        }

        XCTAssert(session.lastURL == url)

    }

    func test_get_resume_called() {

        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask

        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }

        httpClient.get(url: url) { (_, _) in
            // Return data
        }

        XCTAssert(dataTask.resumeWasCalled)
    }

    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: Data?
        httpClient.get(url: URL(string: "http://mockurl")!) { (data, _) in
            actualData = data
        }

        XCTAssertNotNil(actualData)
    }

}
