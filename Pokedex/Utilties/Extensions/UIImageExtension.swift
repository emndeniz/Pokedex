//
//  UIImageExtension.swift
//  Pokedex
//
//  Created by Emin on 8.11.2022.
//

import UIKit

extension UIImage {
    static func getMatchingImageForType(type:String) -> UIImage {
        let nameName = "Type_" + type
        if let image = UIImage(named: nameName) {
            return image
        }else {
            return UIImage(named: "PlaceholderImage")!
        }
    }
}
