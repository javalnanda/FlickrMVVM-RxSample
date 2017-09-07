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

    func test_NumberOfRows_Equals_GalleryViewModel_NumberOfRows() {
        let tableViewNumberOfRows = galleryViewController.tableView.numberOfRows(inSection: 0)
        let galleryViewModelNumberOfRows = galleryViewController.galleryViewModel.numberOfRowsInSection(section: 0)

        XCTAssertEqual(tableViewNumberOfRows, galleryViewModelNumberOfRows, "TableView number of rows should be equal to number of rows returned from GalleryViewModel")
    }

    func test_TableView_DequeCell_IsNotNill() {
        let cell = galleryViewController.tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.cellReuseIdentifier) as? GalleryTableViewCell
        XCTAssertNotNil(cell)
    }

    func test_DataConfiguredForCell_IsCorrect() {

        let photo =  Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo", link: "https://www.flickr.com/photos/jagois/36252189110/", dateTaken: "2017-08-18T15:02:23-08:00", publishedDate: "2017-08-18T13:02:23Z", author: "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", authorId: "30454316@N03", tags: "instagram ifttt")

        // set photo to Gallery View Model which will feed data to datasource
        galleryViewController.galleryViewModel.photosArray.append(photo)
        let indexPath = IndexPath(row: 0, section: 0)
        let cellItem = galleryViewController.galleryViewModel.itemForRowAtIndexPath(indexPath: indexPath)

        let cell = galleryViewController.tableView(galleryViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? GalleryTableViewCell

        XCTAssertEqual(cell?.titleLabel.text, cellItem.titleString)
        XCTAssertEqual(cell?.authorLabel.text, cellItem.authorString)
        XCTAssertEqual(cell?.takenDateLabel.text, cellItem.dateTakenString)
        XCTAssertEqual(cell?.publishedDateLabel.text, cellItem.publishedDateString)
        XCTAssertEqual(cell?.tagsLabel.text, cellItem.tagsString)
    }
}
