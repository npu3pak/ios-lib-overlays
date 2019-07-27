import UIKit
import Overlays

class CustomOverlaySearchViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet var overlay: CustomOverlay!

    private lazy var keyboardAwareOverlays = KeyboardAwareOverlays(controller: self)

    private let searchController = UISearchController(searchResultsController: nil)

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
        super.viewWillAppear(animated)
        keyboardAwareOverlays.startListeningKeyboardEvents()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardAwareOverlays.stopListeningKeyboardEvents()
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard !searchController.isBeingDismissed && !searchController.isBeingPresented else { return }

        keyboardAwareOverlays.show(overlay)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.keyboardAwareOverlays.hide()
        }
    }
}
