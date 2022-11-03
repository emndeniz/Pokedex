import Foundation


// Response of: https://pokeapi.co/api/v2/pokemon-species
/// Response from the `getSpeciesList` endpoint
struct SpeciesResponse : Decodable {
    let count: Int
    let results: [Species]
}

/// Species object returned as part of the `SpeciesResponse` object from the `getSpeciesList` endpoint
struct Species : Decodable{
    let name: String
    let url: URL
}
