import UIKit
import Overlays

class CustomOverlayViewController: UIViewController {

    @IBOutlet var overlay: CustomOverlay!
    @IBOutlet weak var containerView: UIView!

    @IBAction func showInsideVC(_ sender: Any) {
        showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideAllOverlays()
        }
    }

    @IBAction func showInsideView(_ sender: Any) {
        containerView.showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.containerView.hideAllOverlays()
        }
    }
}
