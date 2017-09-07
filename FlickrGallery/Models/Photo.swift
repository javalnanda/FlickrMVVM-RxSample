//
//  Photo.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation

enum ApiKeys {
    static let title = "title"
    static let link = "link"
    static let media = "media"
    static let mKey = "m"
    static let dateTaken = "date_taken"
    static let published = "published"
    static let author = "author"
    static let authorId = "author_id"
    static let tags = "tags"
}

struct Photo {
    let imageUrlString: String?
    let title: String?
    let link: String?
    let dateTaken: String?
    let publishedDate: String?
    let author: String?
    let authorId: String?
    let tags: String?

    init(imageUrlString: String?, title: String? = nil, link: String? = nil, dateTaken: String? = nil, publishedDate: String? = nil, author: String? = nil, authorId: String? = nil, tags: String? = nil) {
        self.imageUrlString = imageUrlString
        self.title = title
        self.link = link
        self.dateTaken = dateTaken
        self.publishedDate = publishedDate
        self.author = author
        self.authorId = authorId
        self.tags = tags
    }

    init?(dict: [String:Any]) {
        guard let title = dict[ApiKeys.title] as? String else { return nil }

        self.title = title

        self.link = dict[ApiKeys.link] as? String ?? ""
        let mediaDictionary = dict[ApiKeys.media] as? [String: AnyObject]
        self.imageUrlString = mediaDictionary?[ApiKeys.mKey] as? String ?? ""
        self.dateTaken = dict[ApiKeys.dateTaken] as? String ?? ""
        self.publishedDate = dict[ApiKeys.published] as? String ?? ""
        self.author = dict[ApiKeys.author] as? String ?? ""
        self.authorId = dict[ApiKeys.authorId] as? String ?? ""
        self.tags = dict[ApiKeys.tags] as? String ?? ""
    }

}
