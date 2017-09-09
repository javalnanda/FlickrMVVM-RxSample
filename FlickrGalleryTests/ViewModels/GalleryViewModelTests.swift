//
//  GalleryViewModelTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
import RxSwift
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
        XCTAssertEqual(galleryViewModel.photosArray.value.count, 0, "Photos Array count should be zero initially")
    }

    func test_AddPhoto_IncreasesCount_ToOne() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg")
        galleryViewModel.photosArray.value.append(photo)
        XCTAssertEqual(galleryViewModel.photosArray.value.count, 1, "Photos Array count shoud be one afer adding a photo")
    }

}
