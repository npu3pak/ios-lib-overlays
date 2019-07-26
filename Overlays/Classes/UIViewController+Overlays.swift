import UIKit

public extension UIViewController {

    /**
     Displays the overlay inside the view controller.
     - Parameter overlay: the overlay view to display.
     - Parameter keyboardHeight: height of the keyboard. Specify this parameter if you want to display the overlay above the keyboard.
     */
    func showOverlay(_ overlay: OverlayView, keyboardHeight: CGFloat = 0) {
        hideOverlay()

        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let bottomIndent = keyboardHeight > 0 ? keyboardHeight : bottomLayoutGuide.length

        if let tableVC = self as? UITableViewController {
            let tableView = tableVC.tableView!
            // Makes the overlay to display above the table view cells.
            overlay.layer.zPosition = 1
            overlay.frame = CGRect(
                x: 0,
                y: 0,
                width: tableView.frame.width,
                height: tableView.frame.height - topLayoutGuide.length - bottomIndent
            )
            // The overlay should not scroll with the table view.
            tableView.isScrollEnabled = false
            tableView.addSubview(overlay)
        } else {
            overlay.frame = CGRect(
                x: 0,
                y: topLayoutGuide.length,
                width: view.bounds.width,
                height: view.bounds.height - topLayoutGuide.length - bottomIndent
            )
            view.addSubview(overlay)
        }
    }

    /**
     Call this method to update the frame of the overlay after layout changes.
     - Parameter keyboardHeight: height of the keyboard. Specify this parameter if you want to display the overlay above the keyboard.
    */
    func updateOverlayFrame(keyboardHeight: CGFloat = 0) {
        let bottomIndent = keyboardHeight > 0 ? keyboardHeight : bottomLayoutGuide.length

        if let tableVC = self as? UITableViewController {
            let tableView = tableVC.tableView!
            tableVC.tableView.subviews
                .filter({$0 is OverlayView})
                .forEach({ overlay in
                    overlay.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: tableView.frame.width,
                        height: tableView.frame.height - topLayoutGuide.length - bottomIndent
                    )})
        } else {
            view.subviews
                .filter({$0 is OverlayView})
                .forEach({ overlay in
                    overlay.frame = CGRect(
                        x: 0,
                        y: topLayoutGuide.length,
                        width: view.bounds.width,
                        height: view.bounds.height - topLayoutGuide.length - bottomIndent
                    )})
        }
    }

    /**
     Hides all overlays displayed inside the view controller.
     */
    func hideOverlay() {
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
