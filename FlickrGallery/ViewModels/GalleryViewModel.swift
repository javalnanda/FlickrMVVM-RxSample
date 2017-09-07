//
//  GalleryViewModel.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation

class GalleryViewModel: NSObject {
    var photosArray = [Photo]()

    func fetchData(query: String? = nil, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        ApiManager.sharedInstance.getFlickrPublicPhotoFeedWith(query: query) { (result) in
            switch result {
            case .success(let data):
                self.photosArray = data.map {Photo(dict: $0)!}
                completion(.success(data))
            case .error(let message):
                completion(.error(message))
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return photosArray.count
    }

    // Returns PhotoViewModel related to the indexPath of the cell
    func itemForRowAtIndexPath(indexPath: IndexPath) -> PhotoViewModel {

        guard photosArray.count > 0 && indexPath.row <= photosArray.count else {
            fatalError(NSLocalizedString("invalidIndexpath", comment: ""))
        }

        return PhotoViewModel(photo: photosArray[indexPath.row])
    }

    // Sort PhotosArray based on Date Taken or Date Published with most recent date on top
    func sortData(orderBy: OrderBy, completion: (Bool) -> Void) {

        switch orderBy {
        case OrderBy.dateTaken:

            photosArray.sort(by: { (photo1, photo2) -> Bool in

                let date1 = getDate(from: photo1.dateTaken!, format: .dateTakenFormat)
                let date2 = getDate(from: photo2.dateTaken!, format: .dateTakenFormat)

                // Sort in descending order latest date first
                if let d1 = date1, let d2 = date2 {
                    return d1 > d2
                }
                return false
            })

            break
        case OrderBy.datePublished:

            photosArray.sort(by: { (photo1, photo2) -> Bool in

                let date1 = getDate(from: photo1.publishedDate!, format: .publishedDateFormat)
                let date2 = getDate(from: photo2.publishedDate!, format: .publishedDateFormat)

                // Sort in descending order latest date first
                if let d1 = date1, let d2 = date2 {
                    return d1 > d2
                }
                return false
            })

            break
        }
        completion(true)
    }
}
