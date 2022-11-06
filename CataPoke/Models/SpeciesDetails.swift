import Foundation

// Response of: https://pokeapi.co/api/v2/pokemon-species/1/
/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails : Decodable {
    let name: String
    let id : Int
    let evolutionChain: EvolutionChain
    let color: Pairs
    let habitat: Pairs
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case evolutionChain = "evolution_chain"
        case color
        case habitat
    }
    
    /// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
    struct EvolutionChain : Decodable {
        let url: URL
    }

    struct Pairs: Codable {
        let name: String
        let url: URL
    }
    
}

