//
//  PhotoViewModelTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery

class PhotoViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_OnInit_Values_NotNil() {
        let photo =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-18T15:02:23-08:00", publishedDate: "2017-08-18T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")

        let photoViewModel = PhotoViewModel(photo: photo)

        XCTAssertNotNil(photoViewModel.imageUrl)
        XCTAssertNotNil(photoViewModel.linkUrl)
        XCTAssertNotNil(photoViewModel.titleString)
        XCTAssertNotNil(photoViewModel.authorString)
        XCTAssertNotNil(photoViewModel.tagsString)
        XCTAssertNotNil(photoViewModel.dateTakenString)
        XCTAssertNotNil(photoViewModel.publishedDateString)
    }

    func test_dateTakenString() {
        let photo =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", dateTaken: "2017-08-18T15:02:23-08:00")

        let photoViewModel = PhotoViewModel(photo: photo)
        XCTAssertEqual(photoViewModel.dateTakenString!, "Taken On \nAugust 18, 2017", "Check that taken date is displayed correctly")
    }

    func test_publishedDateString() {
        let photo =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", publishedDate: "2017-08-18T13:02:23Z" )

        let photoViewModel = PhotoViewModel(photo: photo)
        XCTAssertEqual(photoViewModel.publishedDateString!, "Published On \nAugust 18, 2017", "Check that published date is displayed correctly")
    }
}
