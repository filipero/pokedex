//
//  TappableView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import UIKit

open class TappableView: BaseView {
    public enum AnimationStyle {
        case alpha
        case color(normal: UIColor = .systemBackground, highlighted: UIColor = .systemGray)
    }

    private var tapAction: (() -> Void)?

    private var tapGestureRecognizer: UITapGestureRecognizer?

    /// The minimum touch area of the touchable view, currently **40x40**
    public let minimumTouchArea = CGSize(width: 40, height: 40)

    public var animationStyle = AnimationStyle.alpha {
        didSet {
            if case let .color(normal, _) = self.animationStyle {
                backgroundColor = normal
            }
        }
    }

    // MARK: - Init

    public required init() {
        super.init(frame: .zero)
    }

    open override func initialize() {}

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    ///
    /// - Parameters:
    ///   - subview: The subview added to the touchable view
    ///   - action: The action executed when the touchable view is tapped
    public init(_ subview: UIView, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        addSubview(subview)
        subview.edgesToSuperview()
        onTap(weak: self, action: { _ in action?() })
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    public func addTarget(_ target: Any?, selector: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: selector)
        tap.delegate = self
        tapGestureRecognizer = tap
        addGestureRecognizer(tap)
    }

    @discardableResult
    public func onTap<A: AnyObject>(weak obj: A, action: @escaping ((A) -> Void)) -> Self {
        tapAction = { [weak obj] in
            obj.map { action($0) }
        }
        addTarget(self, selector: #selector(triggerTapAction))

        return self
    }

    /// Sets the action that will be executed when the button is
    /// tapped.
    ///
    /// - Parameter action: The action executed when the
    /// button is tapped.
    @discardableResult
    public func setAction(_ action: @escaping () -> Void) -> Self {
        tapAction = action
        addTarget(self, selector: #selector(triggerTapAction))
        return self
    }

    /// Sets the action that will be executed when the button is
    /// tapped.
    ///
    /// - Parameters:
    ///   - object: An object which reference will be
    ///   weakened avoiding memory leaks.
    ///   - action: The action executed when the button
    ///   is tapped, passing weakened object.
    @discardableResult
    public func setAction<O: AnyObject>(weak obj: O, action: ((O) -> Void)?) -> Self {
        onTap(weak: obj, action: action ?? { _ in })
    }

    // MARK: - Actions

    @objc
    private func triggerTapAction(recognizer: UITapGestureRecognizer) {
        tapAction?()
    }

    // MARK: - Accessibility

    /// Returns a Boolean value indicating whether the receiver contains the specified point.
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var widthAdjustment: CGFloat = 0
        var heightAdjustment: CGFloat = 0

        if bounds.width < minimumTouchArea.width {
            widthAdjustment = (bounds.width - minimumTouchArea.width) / 2
        }

        if bounds.height < minimumTouchArea.height {
            heightAdjustment = (bounds.height - minimumTouchArea.height) / 2
        }

        return bounds.insetBy(dx: widthAdjustment, dy: heightAdjustment).contains(point)
    }
}

extension TappableView: UIGestureRecognizerDelegate {

    private func animateState(isTouching: Bool) {
        UIView.animate(withDuration: 0.2) {
            if case let .color(normal, highlighted) = self.animationStyle {
                self.backgroundColor = isTouching ? highlighted : normal
            } else {
                self.alpha = isTouching ? 0.5 : 1
            }
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateState(isTouching: true)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateState(isTouching: false)
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateState(isTouching: false)
    }
}
