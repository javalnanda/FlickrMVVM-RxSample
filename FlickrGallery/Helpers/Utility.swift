//
//  Utility.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/20/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import Foundation

func getDate(from dateString: String, format: ApiDateFormat) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    if let date = dateFormatter.date(from: dateString) {
      return date
    }
    return nil
}

func getString(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    return dateFormatter.string(from: date)
}
