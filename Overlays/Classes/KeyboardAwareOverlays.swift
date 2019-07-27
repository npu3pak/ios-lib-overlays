import UIKit

/**
 This class is to display overlays above the keyboard.
 */
public class KeyboardAwareOverlays {
    private var keyboardHeight: CGFloat = 0
    private var kayboardAwareOverlays = [UIView]()
    private weak var controller: UIViewController?

    /**
     - Parameter controller: the controller to display overlays.
    */
    public init(controller: UIViewController?) {
        self.controller = controller
    }

    // MARK: - Keyboard events

    /**
     Starts listening for the keyboard events. You should call this method in viewWillAppear() of the view controller.
     */
    public func startListeningKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    /**
     Stops listen for the keyboard events. You should call this method in viewWillDisappear() of the view controller.
     */
    public func stopListeningKeyboardEvents() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc internal func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        keyboardHeight = keyboardFrame.cgRectValue.height
        updateOverlayFrame()
    }

    @objc internal func keyboardWillHide(notification: NSNotification) {
        keyboardHeight = 0
        updateOverlayFrame()
    }

    // MARK: - Overlays API

    /**
    Displays the overlay inside the view controller.
    - Parameter overlay: the overlay view to display.
    */
    public func show(_ overlay: OverlayView) {
        guard let controller = controller else { return }

        hide()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Starts updating the overlay after the keyboard events.
        kayboardAwareOverlays.append(overlay)

        let bottomIndent = keyboardHeight > 0
            ? max(keyboardHeight, controller.bottomLayoutGuide.length)
            : controller.bottomLayoutGuide.length

        if let tableVC = controller as? UITableViewController {
            let tableView = tableVC.tableView!
            // Makes the overlay to display above the table view cells.
            overlay.layer.zPosition = 1
            overlay.frame = CGRect(
                x: 0,
                y: 0,
                width: tableView.frame.width,
                height: tableView.frame.height - controller.topLayoutGuide.length - bottomIndent
            )
            // The overlay should not scroll with the table view.
            tableView.isScrollEnabled = false
            tableView.addSubview(overlay)
        } else {
            overlay.frame = CGRect(
                x: 0,
                y: controller.topLayoutGuide.length,
                width: controller.view.bounds.width,
                height: controller.view.bounds.height - controller.topLayoutGuide.length - bottomIndent
            )
            controller.view.addSubview(overlay)
        }
    }

    /**
     Updates the frame of the overlay after layout changes.
     */
    public func updateOverlayFrame() {
        guard let controller = controller else { return }

        let bottomIndent = keyboardHeight > 0
            ? max(keyboardHeight, controller.bottomLayoutGuide.length)
            : controller.bottomLayoutGuide.length

        if let tableVC = controller as? UITableViewController {
            let tableView = tableVC.tableView!
            tableVC.tableView.subviews
                .filter({ view in self.kayboardAwareOverlays.contains(where: { $0 === view }) })
                .forEach({ overlay in
                    overlay.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: tableView.frame.width,
                        height: tableView.frame.height - controller.topLayoutGuide.length - bottomIndent
                    )})
        } else {
            controller.view.subviews
                .filter({ view in self.kayboardAwareOverlays.contains(where: { $0 === view }) })
                .forEach({ overlay in
                    overlay.frame = CGRect(
                        x: 0,
                        y: controller.topLayoutGuide.length,
                        width: controller.view.bounds.width,
                        height: controller.view.bounds.height - controller.topLayoutGuide.length - bottomIndent
                    )})
        }
    }

    /**
     Hides all overlays displayed inside the view controller.
     */
    public func hide() {
        guard let controller = controller else { return }

        if let tableVC = controller as? UITableViewController {
            tableVC.tableView.isScrollEnabled = true
            tableVC.tableView.subviews
                .filter({$0 is OverlayView})
                .forEach({ overlay in
                    if let i = self.kayboardAwareOverlays.firstIndex(where: {$0 === overlay}) {
                        self.kayboardAwareOverlays.remove(at: i)
                    }
                    overlay.removeFromSuperview()
                })
        } else {
            controller.view.subviews
                .filter({$0 is OverlayView})
                .forEach({ overlay in
                    if let i = self.kayboardAwareOverlays.firstIndex(where: {$0 === overlay}) {
                        self.kayboardAwareOverlays.remove(at: i)
                    }
                    overlay.removeFromSuperview()
                })
        }
    }
}
