//
//  OverlayTemplate.swift
//  Overlays
//
//  Created by Евгений Сафронов on 29/07/2019.
//

import UIKit

/**
 It defines items alignment for the overlay.
*/
public enum OverlayTemplateAlignment {
    /// Items will be in the center of the overlay.
    case center
    /// Items will be in the top of the overlay.
    case top
    /// Items will be in the bottom of the overlay.
    case bottom
}

/**
 A template class for overlays.
 */
open class OverlayTemplate: UIView, OverlayView {

    /**
    An UIStackView instance using to store the overlay subviews. You can use it to adjust alignment or spacing. Also, you can use it to create border constraints for UIView instances used for addView() method.
    */
    public let stackView: UIStackView

    private var buttonListeners = [() -> Void]()

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     Creates an instance of the overlay template that is ready for use with Overlays library.
     - Parameter alignment: alignment of the overlay. If not specified, items will be in the center of the overlay.
     - Parameter margins: margins of the overlay view. By default, it's 20 for each corner.
     */
    public init(alignment: OverlayTemplateAlignment = .center,
                margins: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)) {
        stackView = UIStackView()
        super.init(frame: CGRect.zero)

        addSubview(stackView)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margins.right).isActive = true

        switch alignment {
        case .center:
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        case .top:
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top).isActive = true
        case .bottom:
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins.bottom).isActive = true
        }
    }

    // MARK: - Text

    /**
     Adds an UILabel instance with the specified text, .headline text style, and black color.
     - Parameter text: a text to display.
    */
    open func addHeadline(_ text: String) {
        addText(text, font: UIFont.preferredFont(forTextStyle: .headline), color: UIColor.darkText)
    }

    /**
     Adds an UILabel instance with the specified text, .subheadline text style, and black color.
     - Parameter text: a text to display.
     */
    open func addSubhead(_ text: String) {
        addText(text, font: UIFont.preferredFont(forTextStyle: .subheadline), color: UIColor.darkText)
    }

    /**
     Adds an UILabel instance with the specified text, font, and color.
     - Parameter text: a text to display.
     - Parameter text: a font of the text.
     - Parameter text: a color of the text.
     */
    open func addText(_ text: String, font: UIFont, color: UIColor) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = .center
        addView(label)
    }

    // MARK: - Image

    /**
     Adds an UIImageView instance displayed an UIImage with the specified name.
     - Parameter named: an image name in the project assets catalog.
     */
    open func addImage(named: String) {
        if let image = UIImage(named: "Empty") {
            let imageView = UIImageView(image: image)
            addView(imageView)
        }
    }

    /**
     Adds an UIImageView instance displayed the specified image.
     - Parameter image: an image to display.
     */
    open func addImage(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        addView(imageView)
    }

    // MARK: - Button

    /**
     Adds an UIButton instance with .system style.
     - Parameter text: a text of the button.
     - Parameter listener: a closure for listening .touchUpInside events of the button.
     */
    open func addButton(_ text: String, listener: @escaping () -> Void) {
        let tag = buttonListeners.count
        buttonListeners.append(listener)

        let button = UIButton(type: .system)
        button.tag = tag
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        addView(button)
    }

    @objc private func onButtonClick(sender: UIButton) {
        let tag = sender.tag
        buttonListeners[tag]()
    }

    // MARK: - Separator

    /**
     Adds a separator.
     - Parameter size: a size of the separator.
     */
    open func addSeparator(_ size: CGFloat) {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: size).isActive = true
        view.heightAnchor.constraint(equalToConstant: size).isActive = true
        view.backgroundColor = UIColor.clear
        addView(view)
    }

    // MARK: - View

    /**
     Adds the specified view. Please note that the view must have forced height or the intrinsic content size.

     ### Example: ###
     ````
     let view = UIView()
     view.heightAnchor.constraint(equalToConstant: 30).isActive = true
     addView(view)

     let label = UILabel()
     label.text = "example"
     addView(label)
     ````
     - Parameter view: a view to display.
     */
    open func addView(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
