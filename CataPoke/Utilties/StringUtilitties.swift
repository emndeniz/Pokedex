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
    
    static func getDreamWorldImages(id:String) -> URL?{
        let urlStr = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png"
        return URL(string: urlStr)
    }
    
}
