//
//  GalleryViewModelTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery

class GalleryViewModelTests: XCTestCase {

    var galleryViewModel: GalleryViewModel!

    override func setUp() {
        super.setUp()
        galleryViewModel = GalleryViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_InitialPhotoCount_IsZero() {
        XCTAssertEqual(galleryViewModel.photosArray.count, 0, "Photos Array count should be zero initially")
    }

    func test_AddPhoto_IncreasesCount_ToOne() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg")
        galleryViewModel.photosArray.append(photo)
        XCTAssertEqual(galleryViewModel.photosArray.count, 1, "Photos Array count shoud be one afer adding a photo")
    }

    func test_ItemReturned_ForRow_IsCorrect() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg")
        let photoViewModel = PhotoViewModel(photo: photo)

        galleryViewModel.photosArray.append(photo)
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(photoViewModel == galleryViewModel.itemForRowAtIndexPath(indexPath: indexPath))

    }

    func test_Sorting_By_DateTaken() {
        let photo1 =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo1", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-18T15:02:23-08:00", publishedDate: "2017-08-19T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")
        let photo2 =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo2", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-20T15:02:23-08:00", publishedDate: "2017-08-20T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")

        galleryViewModel.photosArray.append(photo1)
        galleryViewModel.photosArray.append(photo2)

        // without sorting item at first row should return photo1 object which has title Photo1
        let itemForFirstRow = galleryViewModel.itemForRowAtIndexPath(indexPath: IndexPath(row: 0, section: 0)) as PhotoViewModel
        XCTAssertEqual(itemForFirstRow.titleString, "Photo1")

        // sort by date taken
        galleryViewModel.sortData(orderBy: .dateTaken) { _ in
            // after sorting item at first row should return photo2 object which date is more recent than photo1
            let itemForFirstRow = galleryViewModel.itemForRowAtIndexPath(indexPath: IndexPath(row: 0, section: 0)) as PhotoViewModel
            XCTAssertEqual(itemForFirstRow.titleString, "Photo2")
        }
    }

    func test_Sorting_By_PublishedDate() {
        let photo1 =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo1", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-18T15:02:23-08:00", publishedDate: "2017-08-19T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")
        let photo2 =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo2", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-20T15:02:23-08:00", publishedDate: "2017-08-20T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")

        galleryViewModel.photosArray.append(photo1)
        galleryViewModel.photosArray.append(photo2)

        // without sorting item at first row should return photo1 object which has title Photo1
        let itemForFirstRow = galleryViewModel.itemForRowAtIndexPath(indexPath: IndexPath(row: 0, section: 0)) as PhotoViewModel
        XCTAssertEqual(itemForFirstRow.titleString, "Photo1")

        // sort by published date
        galleryViewModel.sortData(orderBy: .datePublished) { _ in
            // after sorting item at first row should return photo2 object which date is more recent than photo1
            let itemForFirstRow = galleryViewModel.itemForRowAtIndexPath(indexPath: IndexPath(row: 0, section: 0)) as PhotoViewModel
            XCTAssertEqual(itemForFirstRow.titleString, "Photo2")
        }
    }
}
