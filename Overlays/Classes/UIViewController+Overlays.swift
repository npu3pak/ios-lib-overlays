import UIKit

public extension UIViewController {

    /**
     Displays the overlay inside the view controller.
     - Parameter overlay: the overlay view to display.
     */
    func showOverlay<T: OverlayView>(_ overlay: T) {
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let tableVC = self as? UITableViewController {
            let tableView = tableVC.tableView!
            // Makes the overlay to display above the table view cells.
            overlay.layer.zPosition = 1
            overlay.frame = CGRect(x: 0, y: 0,
                                   width: tableView.frame.width,
                                   height: tableView.frame.height)
            // The overlay should not scroll with the table view.
            tableView.isScrollEnabled = false
            tableView.addSubview(overlay)
        } else {
            overlay.frame = view.bounds
            view.addSubview(overlay)
        }
    }

    /**
     Hides all overlays displayed inside the view controller.
     */
    func hideAllOverlays() {
        if let tableVC = self as? UITableViewController {
            tableVC.tableView.isScrollEnabled = true
            tableVC.tableView.subviews
                .filter({$0 is OverlayView})
                .forEach({$0.removeFromSuperview()})
        } else {
            view.subviews
                .filter({$0 is OverlayView})
                .forEach({$0.removeFromSuperview()})
        }
    }
}
