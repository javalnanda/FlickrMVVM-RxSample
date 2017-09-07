//
//  HttpClient.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/20/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation
// Protocol for MOCK/Real
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Swift.Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

// MARK: HttpClient Implementation
class HttpClient {

    typealias CompleteClosure = ( _ data: Data?, _ error: Error?) -> Void

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session

    }

    func get( url: URL, callback: @escaping CompleteClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, _, error) in
            callback(data, error)
        }
        task.resume()
    }

}

// MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
