//
//  PhotoTests.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import XCTest
@testable import FlickrGallery

class PhotoTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_WhenGivenImageUrl_SetsImageUrl() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg")
        XCTAssertEqual(photo.imageUrlString, "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", "should set imageUrl")
    }

    func test_WhenGivenTitle_SetsTitle() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", title: "Photo")
        XCTAssertEqual(photo.title, "Photo", "should set title")
    }

    func test_WhenGivenLink_SetsLink() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", link: "https://www.flickr.com/photos/jagois/36252189110/")
        XCTAssertEqual(photo.link, "https://www.flickr.com/photos/jagois/36252189110/", "should set link")
    }

    func test_WhenGivenDateTake_SetsDateTaken() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", dateTaken:"2017-08-18T15:02:23-08:00")
        XCTAssertEqual(photo.dateTaken, "2017-08-18T15:02:23-08:00", "should set date taken")
    }

    func test_WhenGivenPublishedDate_SetsPublishedDate() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", publishedDate:"2017-08-18T13:02:23Z")
        XCTAssertEqual(photo.publishedDate, "2017-08-18T13:02:23Z", "should set published date")
    }

    func test_WhenGivenAuthor_SetsAuthor() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", author:"nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")")
        XCTAssertEqual(photo.author, "nobody@flickr.com (\"Agoisfoto (Jimena Agois)\")", "should set author")
    }

    func test_WhenGivenAuthorId_SetsAuthorId() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", authorId:"30454316@N03")
        XCTAssertEqual(photo.authorId, "30454316@N03", "should set authorId")
    }

    func test_WhenGivenTags_SetsTags() {
        let photo = Photo(imageUrlString: "https://farm5.staticflickr.com/4399/36252189110_5f6284aae1_m.jpg", tags:"instagram ifttt")
        XCTAssertEqual(photo.tags, "instagram ifttt", "should set tags")
    }

    func getJsonMockData() -> [String: Any] {
        let jsonDict: Dictionary = [ "title": "CC1A4291.jpg",
                                     "link": "https://www.flickr.com/photos/lizzypat/35847674864/",
                                     "media": ["m": "https://farm5.staticflickr.com/4434/35847674864_a6f15ae582_m.jpg"],
                                     "date_taken": "2017-08-19T19:34:04-08:00",
                                     "description": " <p><a href=\"https://www.flickr.com/people/lizzypat/\">epsmith2421</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/lizzypat/35847674864/\" title=\"CC1A4291.jpg\"><img src=\"https://farm5.staticflickr.com/4434/35847674864_a6f15ae582_m.jpg\" width=\"240\" height=\"133\" alt=\"CC1A4291.jpg\"/></a></p>",
                                     "published": "2017-08-20T05:35:14Z",
                                     "author": "nobody@flickr.com (\"epsmith2421\")",
                                     "author_id": "75850532@N05",
                                     "tags": "cars 365project2017 pricevillecarshow2017"
            ] as [String : Any]
        return jsonDict
    }

    func test_WhenInitWithDictionary_IsNotNill() {
        let photo = Photo(dict: getJsonMockData())
        XCTAssertNotNil(photo)
    }

    func test_WhenInitWithDictionary_SetsCorrectValue() {

        let photo = Photo(dict: getJsonMockData())
        XCTAssertEqual(photo?.title, "CC1A4291.jpg", "Title value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.link, "https://www.flickr.com/photos/lizzypat/35847674864/", "Link value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.imageUrlString, "https://farm5.staticflickr.com/4434/35847674864_a6f15ae582_m.jpg", "Image url value should match with media.m value passed via dict during initialization")
        XCTAssertEqual(photo?.dateTaken, "2017-08-19T19:34:04-08:00", "Date taken value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.publishedDate, "2017-08-20T05:35:14Z", "Published date value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.author, "nobody@flickr.com (\"epsmith2421\")", "Author value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.authorId, "75850532@N05", "Author Id value should match with that passed via dict during initialization")
        XCTAssertEqual(photo?.tags, "cars 365project2017 pricevillecarshow2017", "Tags value should match with that passed via dict during initialization")
    }

}
