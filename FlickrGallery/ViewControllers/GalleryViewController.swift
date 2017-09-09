//
//  GalleryViewController.swift
//  FlickrGallery
//
//  Created by Javal Nanda on 8/19/17.
//  Copyright © 2017 Javal Nanda. All rights reserved.
//

import UIKit
import MBProgressHUD
import Photos
import MessageUI
import RxSwift
import RxCocoa

enum OrderBy {
    case dateTaken
    case datePublished
}

class GalleryViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let galleryViewModel = GalleryViewModel()
    let disposeBag = DisposeBag()

    // refreshcontrol for pull to refresh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(GalleryViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 320
        tableView.keyboardDismissMode = .onDrag

        galleryViewModel.photosArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: GalleryTableViewCell.cellReuseIdentifier, cellType: GalleryTableViewCell.self)) { _, photo, cell in
                cell.setData(photoViewModel: PhotoViewModel(photo: photo))
            }
            .addDisposableTo(disposeBag) //5

        // Add Pull to refresh
        self.tableView.addSubview(self.refreshControl)

        // Fetch flickr public feed data
        fetchData()
    }

    func fetchData(query: String? = nil) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        galleryViewModel.fetchData(query: query) { (result) in
            DispatchQueue.main.async(execute: {
                MBProgressHUD.hide(for: self.view, animated: true)
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            })

            switch result {
            case .success( _):
                break

            case .error(let message):
                self.showAlertWith(title: NSLocalizedString("defaultErrorTitle", comment: ""), message: message)
                break
            }
        }
    }

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Show Alert utility func
extension GalleryViewController {
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}
