//
//  GalleryTableViewCell.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import UIKit
import SDWebImage

enum ControlAction: Int {
    case openInBrowser = 11
    case saveImage = 12
    case shareImage = 13
}

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var takenDateLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!

    static let cellReuseIdentifier = "GalleryTableViewCell"
    var photoViewModel: PhotoViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Set values for UI components
    func setData(photoViewModel: PhotoViewModel) {
        self.photoViewModel = photoViewModel
        self.titleLabel.text = photoViewModel.titleString
        self.authorLabel.text = photoViewModel.authorString
        self.takenDateLabel.text = photoViewModel.dateTakenString
        self.publishedDateLabel.text = photoViewModel.publishedDateString

        if let imageUrl = photoViewModel.imageUrl {
            imgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(imageLiteralResourceName: "placeholder"))
        }
        self.tagsLabel.text = photoViewModel.tagsString
    }

}
