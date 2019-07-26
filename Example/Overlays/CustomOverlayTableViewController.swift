import UIKit
import Overlays

class CustomOverlayTableViewController: UITableViewController {

    @IBOutlet var overlay: CustomOverlay!
    @IBOutlet weak var cell: UITableViewCell!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }

    @IBAction func showInsideTable(_ sender: Any) {
        showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideOverlay()
        }
    }

    @IBAction func showInsideCell(_ sender: Any) {
        cell.showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cell.hideOverlay()
        }
    }
}
