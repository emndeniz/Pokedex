//
//  StringUtilitties.swift
//  CataPoke
//
//  Created by Emin on 4.11.2022.
//

import Foundation


struct StringUtilities {
    
    /// This function extracts pokemon ID from Species request
    /// - Parameter urlStr: Species request url
    /// - Returns: Pokemon ID
    static func getPokemonIDFromSpeciesResponse(urlStr:String) -> String{
        var components = urlStr.components(separatedBy: "/pokemon-species/")
        components[1].removeLast()
        
        return components[1]
    }
    
    /// This function generates image URL from Species request
    /// - Parameter urlStr: Species request url
    /// - Returns: Optional image url
    static func getImageURLFromSpeciesResponse(urlStr:String) -> URL? {
        let pokemonID = getPokemonIDFromSpeciesResponse(urlStr: urlStr)
        let imageURLStr = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png"
        return URL(string: imageURLStr)
    }
    
    /// Retrieves big pokemon image from given ID
    /// - Parameter id: pokemon ID
    /// - Returns: Image URL
    static func getBigPokemonImageFromId(id:Int) -> URL?{
        let urlStr = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png"
        return URL(string: urlStr)
    }
    
    /// Retrieves big pokemon image from given url
    /// - Parameter urlStr: Url string
    /// - Returns: Image Url
    static func getBigPokemonImageFromSpecyUrl(urlStr:String) -> URL?{
        guard let id = Int(getPokemonIDFromSpeciesResponse(urlStr: urlStr)) else {
            return nil
        }

        return getBigPokemonImageFromId(id: id)
    }
    
}
