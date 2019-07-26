//
//  CustomOverlayViewController.swift
//  Overlays_Example
//
//  Created by Евгений Сафронов on 26/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

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
