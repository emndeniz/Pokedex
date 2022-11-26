//
//  StringExtension.swift
//  CataPoke
//
//  Created by Emin on 4.11.2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
