//
//  Action.swift
//  CataPoke
//
//  Created by Emin on 7.11.2022.
//

import UIKit

enum ActionStyle {
    case normal
    case destructive
    
    // Handle the themes
    var titleColor: UIColor {
        return .primaryTextColor
    }
    // Background color of actionbutton
    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return .primaryLightColor.withAlphaComponent(0.5)
        case .destructive:
            return .secondaryLightColor
        }
    }
    
    var highlightedTitleColor: UIColor {
        switch self {
        case .normal, .destructive :
            return .primaryTextColor
        }
    }
}
// A custom version of UIAlertAction
class Action {
    var title: String
    var style: ActionStyle
    var actionHandler: () -> Void

    init(with title: String, style: ActionStyle = .normal, actionHandler: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.actionHandler = actionHandler
    }
}
