//
//  ApiManager.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

class ApiManager: NSObject {

    static let sharedInstance = ApiManager()

    // Set feed format to json and pass nojsoncallback=1 in order to receive response in pure json without jsonFlickrFeed() wrapper
    let endPoint = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"

    // Initializing/Injecting httpclient with URLsession.shared
    let httpClient = HttpClient(session: URLSession.shared)

    func getFlickrPublicPhotoFeedWith(query: String? = nil, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {

        guard let url = URL(string: getFeedUrlStringFor(query: query)) else { return completion(.error(NSLocalizedString("invalidUrlError", comment: ""))) }

        httpClient.get(url: url) { (data, error) in

            guard error == nil else { return completion(.error(error!.localizedDescription)) }
            guard let data = data else { return completion(.error(error?.localizedDescription ?? NSLocalizedString("noNewItem", comment: "")))
            }
            do {
                let improperDataString = String(data: data, encoding: .utf8)
                // Corrected String: replace escaped single quotes \' which are invalid for json format with just single quotes '
                let correctDataString = improperDataString?.replacingOccurrences(of: "\\'", with: "'")
                let correctData = correctDataString?.data(using: .utf8)
                if let json = try JSONSerialization.jsonObject(with: correctData!, options: [.allowFragments]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else {
                        return completion(.error(error?.localizedDescription ?? NSLocalizedString("noNewItem", comment: "")))
                    }
                    DispatchQueue.main.async {
                        completion(.success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.error(error.localizedDescription))
            }
        }
    }

    func getFeedUrlStringFor(query: String? = nil) -> String {
        let urlString = query != nil ? "\(endPoint)&tags=\(query ?? "")" : endPoint
        return urlString
    }
}
