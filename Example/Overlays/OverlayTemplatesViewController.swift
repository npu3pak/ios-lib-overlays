//
//  OverlayTemplatesViewController.swift
//  Overlays_Example
//
//  Created by Евгений Сафронов on 29/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Overlays

class OverlayTemplatesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let overlay = OverlayTemplate(alignment: .center)
        overlay.addImage(named: "Empty")
        overlay.addSeparator(30)
        overlay.addHeadline("We are empty :(")
        overlay.addSeparator(8)
        overlay.addSubhead("Dear user. Try to reload us to see what we can do for you.")
        overlay.addSeparator(20)
        overlay.addButton("Reload", listener: { print("reload") })
        showOverlay(overlay)
    }
}
