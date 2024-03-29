//
//  UIView + Extension.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import UIKit

/// Variables
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

/// Methods
extension UIView {
    func asCard(backgroundColor: UIColor = .systemBackground, shadowOffset: CGSize = .init(width: 0, height: 0.5), shadowRadius: CGFloat = 0.75, shadowOpacity: Float = 0.19, cornerRadius: CGFloat = 8, shadowColor: CGColor = UIColor.label.cgColor) -> Self {
        self.backgroundColor = backgroundColor
        self.layer.shadowColor = shadowColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.cornerRadius = cornerRadius
        return self
    }

    func asUIView(_ closure: (UIView) -> Void = { _ in }) -> UIView {
        let rootView = self

        let view = UIView()
        view.addSubview(rootView)
        rootView.edgesToSuperview()

        closure(view)

        return view
    }

    func asUIView<ViewType: UIView>(_ container: ViewType.Type, closure: (ViewType) -> Void = { _ in }) -> ViewType {
        let rootView = self

        let view = ViewType()
        view.addSubview(rootView)
        rootView.edgesToSuperview()

        closure(view)

        return view
    }
}
