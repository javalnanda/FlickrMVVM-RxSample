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

        // Configure Search
        configureSearch()
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

    func configureSearch() {
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { query in return query.characters.count >= 3 } //Trigger search only if query length is 3 letters or more
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                // We now do our "API Request" to search with tags.
                self.fetchData(query: query)
            })
            .addDisposableTo(disposeBag) // Don't forget to add this to disposeBag. We want to dispose it on deinit.

    }

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        //clear search field on pull to refresh
        searchBar.text = ""
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
