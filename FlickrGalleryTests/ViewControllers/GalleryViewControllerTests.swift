//
//  GalleryViewControllerTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery
class GalleryViewControllerTests: XCTestCase {

    var galleryViewController: GalleryViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "GalleryViewController")
        galleryViewController = viewController as? GalleryViewController

        _ = galleryViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(galleryViewController.tableView)
    }

    func test_GalleryViewModel_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(galleryViewController.galleryViewModel)
    }

    func test_TableView_DequeCell_IsNotNill() {
        let cell = galleryViewController.tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.cellReuseIdentifier) as? GalleryTableViewCell
        XCTAssertNotNil(cell)
    }

}
