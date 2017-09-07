//
//  PhotoViewModel.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}

class PhotoViewModel: NSObject {

    var imageUrl: URL?
    var titleString: String?
    var linkUrl: URL?
    var dateTakenString: String?
    var publishedDateString: String?
    var authorString: String?
    var tagsString: String?

    init(photo: Photo) {
        if let imageUrlString = photo.imageUrlString {
            self.imageUrl = URL.init(string: imageUrlString)!
        }

        self.titleString = photo.title ?? ""

        if let linkUrlString = photo.link {
            self.linkUrl = URL.init(string: linkUrlString)!
        }

        if let author = photo.author {
            let startIndex = author.endIndex(of: "(\"")
            let endIndex = author.index(of: "\")")
            // Extract author name from :: nobody@flickr.com (\"yuliana.tomalyunas\") ==> yuliana.tomalyunas
            self.authorString = "Posted by: \(author.substring(with: startIndex!..<endIndex!))"
        }

        if photo.tags != nil && !((photo.tags?.isEmpty)!) {
            //API does not return comma separated tags so we separate tags considering space as a separator
            self.tagsString = "#\(photo.tags?.replacingOccurrences(of: " ", with: " #") ?? "")"
        }

        // Server format received 2017-08-18T15:02:23-08:00
        if let dateTaken = photo.dateTaken {
            if let dateFromString = getDate(from: dateTaken, format: .dateTakenFormat) {
                let stringFromDate = getString(from: dateFromString)
                self.dateTakenString = "Taken On \n\(stringFromDate)"
            }
        }

        // Server format received  2017-08-18T13:02:23Z
        if let publishDate = photo.publishedDate {
            if let dateFromString = getDate(from: publishDate, format: .publishedDateFormat) {
                let stringFromDate = getString(from: dateFromString)
                self.publishedDateString = "Published On \n\(stringFromDate)"
            }
        }
    }

    // Implement method of Equatable protocol to compare two PhotoViewModels for equality
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        if lhs.imageUrl != rhs.imageUrl {
            return false
        }
        if lhs.titleString != rhs.titleString {
            return false
        }
        if lhs.linkUrl != rhs.linkUrl {
            return false
        }
        if lhs.dateTakenString != rhs.dateTakenString {
            return false
        }
        if lhs.publishedDateString != rhs.publishedDateString {
            return false
        }
        if lhs.authorString != rhs.authorString {
            return false
        }
        if lhs.tagsString != rhs.tagsString {
            return false
        }
        return true
    }

}
