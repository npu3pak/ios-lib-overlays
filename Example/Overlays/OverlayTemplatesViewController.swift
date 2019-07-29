//
//  OverlayTemplatesViewController.swift
//  Overlays_Example
//
//  Created by Евгений Сафронов on 29/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Overlays
import MBProgressHUD

class OverlayTemplatesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showEmpty()
    }

    // An OverlayTemplate usage example.
    func showEmpty() {
        let overlay = OverlayTemplate(alignment: .center)
        overlay.addImage(named: "Empty")
        overlay.addSeparator(30)
        overlay.addHeadline("No results :(")
        overlay.addSeparator(8)
        overlay.addSubhead("Please try again later.")
        overlay.addSeparator(20)
        overlay.addButton("Retry", listener: { [unowned self] in self.reload() })
        showOverlay(overlay)
    }

    // The MBProgressHUD library usage example.
    func reload() {
        let hudContainer = UIView()
        MBProgressHUD.showAdded(to: hudContainer, animated: true)

        let overlay = OverlayTemplate(alignment: .center)
        overlay.addView(hudContainer)
        showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showEmpty()
        }
    }
}
