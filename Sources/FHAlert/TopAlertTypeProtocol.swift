//
//  TopAlertTypeProtocol.swift
//  TopAlertView
//
//  Created by Bassam Hillo on 27/12/2023.
//

import UIKit

/// Represents the type of alert to be displayed.
public protocol TopAlertTypeProtocol {
    var icon: UIImage? { get }
    var iconColor: UIColor? { get }
}

/// Represents the type of alert to be displayed.
public enum TopAlertType: TopAlertTypeProtocol {
    case success
    case failure
    case info

    /// Retrieves the icon image associated with the alert type.
    public var icon: UIImage? {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle.fill")
        case .failure:
            return UIImage(systemName: "xmark.circle.fill")
        case .info:
            return UIImage(systemName: "info.circle.fill")
        }
    }

    /// Retrieves the icon color associated with the alert type.
    public var iconColor: UIColor? {
        switch self {
        case .success:
            return UIColor(
                named: "greenSuccess",
                in: .module,
                compatibleWith: nil
            )
        case .failure:
            return UIColor(
                named: "redError",
                in: .module,
                compatibleWith: nil
            )
        case .info:
            return UIColor(
                named: "orangeInfo",
                in: .module,
                compatibleWith: nil
            )?.withAlphaComponent(0.9)
        }
    }
}
