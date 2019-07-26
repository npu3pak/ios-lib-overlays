//
//  CustomOverlayTableViewController.swift
//  Overlays_Example
//
//  Created by Евгений Сафронов on 26/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Overlays

class CustomOverlayTableViewController: UITableViewController {

    @IBOutlet var overlay: CustomOverlay!

    @IBAction func showInsideTable(_ sender: Any) {
        showOverlay(overlay)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideAllOverlays()
        }
    }
    
}
