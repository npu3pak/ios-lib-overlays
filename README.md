# Overlays

[![Version](https://img.shields.io/cocoapods/v/Overlays.svg?style=flat)](https://cocoapods.org/pods/Overlays)
[![License](https://img.shields.io/cocoapods/l/Overlays.svg?style=flat)](https://cocoapods.org/pods/Overlays)
[![Platform](https://img.shields.io/cocoapods/p/Overlays.svg?style=flat)](https://cocoapods.org/pods/Overlays)

[Complete API reference](https://npu3pak.github.io/ios-lib-overlays/index.html)

A library for displaying an empty list message or a loading indicator. You can show any custom view atop of a view controller content.

![Overview image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/Overview.gif)

## Requirements
- iOS 9+
- Swift 5
- XCode 10.3+

## Installation

Overlays is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Overlays'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Prepare the overlay view

Create a custom class for the overlay view. Implement the OverlayView protocol.

```swift
import Overlays

class CustomOverlay: UIView, OverlayView {
}
```

### Creating overlay views with template

You can use OverlayTemplate class to make overlays.

```swift
import Overlays
...
let overlay = OverlayTemplate(alignment: .center)
overlay.addImage(named: "Empty")
overlay.addSeparator(30)
overlay.addHeadline("No results :(")
overlay.addSeparator(8)
overlay.addSubhead("Please try again later.")
overlay.addSeparator(20)
overlay.addButton("Retry", listener: { [unowned self] in self.reload() })
showOverlay(overlay)
...
```

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/OverlayTemplate.png)

You can integrate custom progress indicators as well.

```swift
import Overlays
import MBProgressHUD
...
let hudContainer = UIView()
MBProgressHUD.showAdded(to: hudContainer, animated: false)

let overlay = OverlayTemplate(alignment: .center)
overlay.addView(hudContainer)
showOverlay(overlay)
...
```

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/MBProgressHUD.png)

### Displaying inside a View Controller

```swift
import Overlays

class CustomOverlayViewController: UIViewController {
    @IBOutlet var overlay: CustomOverlay!

    func show() {
        showOverlay(overlay)
    }

    func hide() {
        hideOverlay()
    }
...
}
```

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/ViewController.gif)

### Displaying atop of a View

```swift
import Overlays
...
@IBOutlet var overlay: CustomOverlay!
@IBOutlet weak var containerView: UIView!

func show() {
    containerView.showOverlay(overlay)
}

func hide() {
    containerView.hideOverlay()
}
...
```

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/View.gif)

### Displaying above the keyboard

```swift
import Overlays

class CustomOverlayViewController: UIViewController {
    @IBOutlet var overlay: CustomOverlay!

    private lazy var keyboardAwareOverlays = KeyboardAwareOverlays(controller: self)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardAwareOverlays.startListeningKeyboardEvents()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardAwareOverlays.stopListeningKeyboardEvents()
    }

    func show() {
        keyboardAwareOverlays.showOverlay(overlay)
    }

    func hide() {
        keyboardAwareOverlays.hideOverlay()
    }
...
}
```

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/AboveKeyboard.gif)

## Author

Evgeniy Safronov, evsafronov.personal@yandex.ru, https://ios-dev.ru

## License

Overlays is available under the MIT license. See the LICENSE file for more info.
The [MBProgressHUD](https://github.com/jdg/MBProgressHUD) library, used in the example project, is available under the MIT license.
