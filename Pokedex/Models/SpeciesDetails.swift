import Foundation

// Response of: https://pokeapi.co/api/v2/pokemon-species/1/
/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails : Decodable {
    let name: String
    let id : Int
    let evolutionChain: EvolutionChain
    let color: Pairs
    let habitat: Pairs
    let isMytical: Bool
    let isLegendary: Bool
    let flavorTextEntries:[FlavourTextEnries]?
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case evolutionChain = "evolution_chain"
        case isLegendary = "is_legendary"
        case isMytical = "is_mythical"
        case color
        case habitat
        case flavorTextEntries = "flavor_text_entries"
    }
    
    /// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
    struct EvolutionChain : Decodable {
        let url: URL
    }
    
    struct Pairs: Codable {
        let name: String
        let url: URL
    }
    
    struct FlavourTextEnries: Decodable {
        let flavorText: String?
        let language: Language?
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
    
    struct Language: Decodable {
        let name: String?
        let url: String?
    }
    
}

