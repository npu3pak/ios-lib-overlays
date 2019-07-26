import UIKit

public extension UIView {

    /**
     Disables user interactions and displays the overlay atop of the current view.
     - Parameter overlay: the overlay view to display.
    */
    func showOverlay<T: OverlayView>(_ overlay: T) {
        hideAllOverlays()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        isUserInteractionEnabled = false

        // It's preferable to place overlay atop of the current view.
        if let superview = superview {
            overlay.frame = frame
            superview.addSubview(overlay)
        } else {
            overlay.frame = bounds
            addSubview(overlay)
        }
    }

    /**
     Enables user interactions and hides all overlays displayed for the current view.
    */
    func hideAllOverlays() {
        isUserInteractionEnabled = true

        let container = superview ?? self
        container.subviews
            .filter({$0 is OverlayView})
            .forEach({$0.removeFromSuperview()})
    }
}
