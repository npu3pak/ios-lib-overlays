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

## Usage

### Prepare overlay view

Create a custom class for the overlay view. Implement the OverlayView protocol.

```swift
import Overlays

class CustomOverlay: UIView, OverlayView {
}
```

### Inside a View Controller

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/ViewController.gif)

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
```

### Atop of a View

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/ViewController.gif)

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

### Above the keyboard

![Example image](https://raw.githubusercontent.com/npu3pak/ios-lib-overlays/master/Images/AboveKeyboard.gif)

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
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Evgeniy Safronov, evsafronov.personal@yandex.ru, https://ios-dev.ru

## License

Overlays is available under the MIT license. See the LICENSE file for more info.
