//
//  OverlayTemplate.swift
//  Overlays
//
//  Created by Евгений Сафронов on 29/07/2019.
//

import UIKit

/**
 A template class for overlays.
 */
public class OverlayTemplate: UIView, OverlayView {

    public let stackView: UIStackView

    private var buttonListeners = [() -> Void]()

    public enum Alignment {
        case center
        case top
        case bottom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(alignment: Alignment = .center, margins: CGFloat = 20) {
        stackView = UIStackView()
        super.init(frame: CGRect.zero)

        addSubview(stackView)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margins).isActive = true

        switch alignment {
        case .center:
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        case .top:
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: margins).isActive = true
        case .bottom:
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins).isActive = true
        }
    }

    // MARK: - Text

    public func addHeadline(_ text: String) {
        addText(text, font: UIFont.preferredFont(forTextStyle: .headline), color: UIColor.darkText)
    }

    public func addSubhead(_ text: String) {
        addText(text, font: UIFont.preferredFont(forTextStyle: .subheadline), color: UIColor.darkText)
    }

    public func addText(_ text: String, font: UIFont, color: UIColor) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = .center
        addView(label)
    }

    // MARK: - Image

    public func addImage(named: String) {
        if let image = UIImage(named: "Empty") {
            let imageView = UIImageView(image: image)
            addView(imageView)
        }
    }

    // MARK: - Button

    public func addButton(_ text: String, listener: @escaping () -> Void) {
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

    public func addSeparator(_ size: CGFloat) {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: size).isActive = true
        view.heightAnchor.constraint(equalToConstant: size).isActive = true
        view.backgroundColor = UIColor.clear
        addView(view)
    }

    // MARK: - View

    public func addView(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
