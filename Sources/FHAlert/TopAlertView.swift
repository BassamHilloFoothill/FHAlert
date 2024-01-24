//
//  TopAlertView.swift
//  Paycard
//
//  Created by Bassam Hillo on 08/11/2023.
//  Copyright © 2023 R365. All rights reserved.
//

import UIKit

// MARK: - Top Alert View

/// A custom view for displaying an alert with an icon, title, and subtitle.
public class TopAlertView: UIView {

    // MARK: - Private Properties

    /// The view that provides a blurred background effect.
    private var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    /// The image view that displays the alert icon.
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    /// The label that displays the main title of the alert.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.textColor = UIColor(
            named: "mainBlack",
            in: .module,
            compatibleWith: nil
        )
        return label
    }()

    /// The label that displays the subtitle of the alert.
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 5
        label.textColor = UIColor(
            named: "grayText",
            in: .module,
            compatibleWith: nil
        )
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Shows a custom alert view at the top of the screen, removing any existing top alert views.
    /// - Parameters:
    ///  - title: The alert title.
    ///  - subTitle: The alert subtitle.
    ///  - type: The alert type.
    ///  - hasTopPadding: Bool to detrmine adding top padding to the view
    ///  - completion: A completion block to be executed after the alert is displayed.
    public static func show(
        title: String,
        subTitle: String,
        type: TopAlertTypeProtocol,
        hasTopPadding: Bool = false,
        completion: (() -> Void)? = nil
    ) {

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        let currentTopAlertViews = window.subviews.filter({ $0 is TopAlertView })
        currentTopAlertViews.forEach({ $0.removeFromSuperview() })

        let alertView = TopAlertView()

        alertView.configureView(
            title: title,
            subTitle: subTitle,
            type: type
        )

        addTopAlertView(
            view: alertView,
            hasTopPadding: hasTopPadding,
            in: window
        )

        alertView.displayView(duration: 3) {
            completion?()
        }
    }

    // MARK: - Configuration

    /// Configures the view with specified title, subtitle, and alert type.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - subTitle: The subtitle of the alert.
    ///   - type: The type of the alert (success, failure, info).
    func configureView(
        title: String,
        subTitle: String,
        type: TopAlertTypeProtocol
    ) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        iconImageView.image = type.icon
        iconImageView.tintColor = type.iconColor
    }

    // MARK: - Private Setup

    /// Sets up the view by adding and configuring subviews and appearance.
    private func initialize() {
        configureGestureRecognizer()
        configureShadowView()
        configureSubViews()
    }

    /// Configures and adds subviews to the main view.
    private func configureSubViews() {
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(visualEffectView)

        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        setupConstraints()
    }

    /// Sets up constraints for subviews.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for iconImageView
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),

            // Constraints for titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            // Constraints for subTitleLabel
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    /// Configures the shadow effect for the view.
    private func configureShadowView() {
        let shadowColor = UIColor(
            named: "shadow",
            in: .module,
            compatibleWith: nil
        )

        layer.shadowColor = shadowColor?.withAlphaComponent(0.65).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }

    /// Configures a gesture recognizer for the view.
    private func configureGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
        addGestureRecognizer(gesture)
    }

    // MARK: - Interaction Handlers

    /// Handles the tap gesture, triggering the removal of the view.
    /// - Parameter sender: The gesture recognizer that triggered the action.
    @objc private func clickAction(_ sender: UITapGestureRecognizer) {
        removeView()
    }

    /// Animates and removes the view from its superview.
    private func removeView() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseIn,
            animations: {
                self.frame.origin.y = -self.bounds.height
            },
            completion: { _ in
                self.removeFromSuperview()
            }
        )
    }

    // MARK: - Public Interface

    /// Displays the alert view with animation.
    /// - Parameters:
    ///   - duration: Optional duration after which the alert will be removed.
    ///   - completion: Optional completion handler after the alert is removed.
    private func displayView(
        duration: TimeInterval?,
        completion: (() -> Void)? = nil
    ) {
        frame.origin.y = -100
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.frame.origin.y = 0
        }, completion: { _ in
            if let duration = duration {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    completion?()
                    self.removeView()
                }
            }
        })
    }

    /// Add top alert view to the window.
    /// - Parameters:
    ///   - view: The alert view to add.
    ///   - hasTopPadding: Bool to detrmine adding top padding to the view
    ///   - window: The window to add the alert view to.
    private static func addTopAlertView(
        view: UIView,
        hasTopPadding: Bool,
        in window: UIWindow
    ) {
        view.layer.zPosition = 99
        view.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(view)

        let topPadding: CGFloat = hasTopPadding ? 20 : 0
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: window.layoutMarginsGuide.topAnchor, constant: topPadding),
            view.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20)
        ])
    }
}
