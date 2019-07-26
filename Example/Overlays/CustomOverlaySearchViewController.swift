//
//  CustomOverlaySearchViewController.swift
//  Overlays_Example
//
//  Created by Евгений Сафронов on 26/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Overlays

class CustomOverlaySearchViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet var overlay: CustomOverlay!

    private let searchController = UISearchController(searchResultsController: nil)
    private var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }

    // MARK: - Keyboard handling

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        keyboardHeight = keyboardFrame.cgRectValue.height
        updateOverlayFrame(keyboardHeight: keyboardHeight)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardHeight = 0
        updateOverlayFrame(keyboardHeight: keyboardHeight)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard !searchController.isBeingDismissed && !searchController.isBeingPresented else { return }

        showOverlay(overlay, keyboardHeight: keyboardHeight)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideOverlay()
        }
    }
}
