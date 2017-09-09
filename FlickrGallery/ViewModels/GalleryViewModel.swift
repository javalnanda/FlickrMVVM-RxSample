//
//  GalleryViewModel.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation
import RxSwift

class GalleryViewModel: NSObject {
    var photosArray: Variable<[Photo]> = Variable([])
    func fetchData(query: String? = nil, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        ApiManager.sharedInstance.getFlickrPublicPhotoFeedWith(query: query) { (result) in
            switch result {
            case .success(let data):
                self.photosArray.value = data.map {Photo(dict: $0)!}
                completion(.success(data))
            case .error(let message):
                completion(.error(message))
            }
        }
    }
}
