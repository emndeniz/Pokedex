//
//  ColorExtensiopn.swift
//  Pokedex
//
//  Created by Emin on 4.11.2022.
//

import UIKit


extension UIColor {
    static let defaultBackgroundColor:UIColor = UIColor(named: "defaultBackgroundColor")!
    static let cellBackgroundcolor:UIColor = UIColor(named: "cellBackgroundcolor")!
    static let primaryColor:UIColor = UIColor(named: "primaryColor")!
    static let primaryDarkColor:UIColor = UIColor(named: "primaryDarkColor")!
    static let primaryLightColor:UIColor = UIColor(named: "primaryLightColor")!
    static let primaryTextColor:UIColor = UIColor(named: "primaryTextColor")!
    static let secondaryColor:UIColor = UIColor(named: "secondaryColor")!
    static let secondaryDarkColor:UIColor = UIColor(named: "secondaryDarkColor")!
    static let secondaryLightColor:UIColor = UIColor(named: "secondaryLightColor")!
    static let secondaryTextColor:UIColor = UIColor(named: "secondaryTextColor")!
    
    
    
    ///  This function generates matching colors with the given image names
    ///  List is obtained from the https://github.com/PokeAPI/pokeapi/blob/master/data/v2/csv/pokemon_colors.csv
    /// - Parameter colorName: Name of the color
    /// - Returns: Matching UIColor
    static func getMatchingColor(colorName:String) -> UIColor {
        switch colorName {
        case "black" :
            return UIColor(named: "PokemonBlack") ?? .defaultBackgroundColor
        case "blue" :
            return UIColor(named: "PokemonBlue") ?? .defaultBackgroundColor
        case "brown":
            return UIColor(named: "PokemonBrown") ?? .defaultBackgroundColor
        case "gray":
            return UIColor(named: "PokemonGray") ?? .defaultBackgroundColor
        case "green":
            return UIColor(named: "PokemonGreen") ?? .defaultBackgroundColor
        case "pink":
            return UIColor(named: "PokemonPink") ?? .defaultBackgroundColor
        case "purple":
            return UIColor(named: "PokemonPurple") ?? .defaultBackgroundColor
        case "red":
            return UIColor(named: "PokemonRed") ?? .defaultBackgroundColor
        case "white":
            return UIColor(named: "PokemonWhite") ?? .defaultBackgroundColor
        case "yellow":
            return UIColor(named: "PokemonYellow") ?? .defaultBackgroundColor
        default:
            return .defaultBackgroundColor
        }
    }
}
