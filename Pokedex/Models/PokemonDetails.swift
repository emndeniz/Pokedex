//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Emin on 7.11.2022.
//

import Foundation

import Foundation

// MARK: - CountryResponseModel
struct PokemonDetails: Decodable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let height: Int?
    let id: Int?
    let isDefault: Bool?
    let moves: [Move]?
    let name: String?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case id
        case isDefault = "is_default"
        case moves
        case name
        case sprites
        case stats
        case types
        case weight
        
        
    }
    
    // MARK: - Ability
    struct Ability:Decodable {
        let ability: Pairs?
        let isHidden: Bool?
        let slot: Int?
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
        
    }

    // MARK: - Pairs
    struct Pairs: Decodable {
        let name: String?
        let url: String?
    }

    // MARK: - GameIndex
    struct GameIndex:Decodable {
        let gameIndex: Int?
        let version: Pairs?
        
        enum CodingKeys: String, CodingKey {
            case gameIndex = "game_index"
            case version
        }
    }

    // MARK: - Move
    struct Move:Decodable {
        let move: Pairs?
        let versionGroupDetails: [VersionGroupDetail]?
        
        enum CodingKeys: String, CodingKey {
            case versionGroupDetails = "version_group_details"
            case move
        }
    }

    // MARK: - VersionGroupDetail
    struct VersionGroupDetail:Decodable {
        let levelLearnedAt: Int?
        let moveLearnMethod, versionGroup: Pairs?
        
        enum CodingKeys: String, CodingKey {
            case levelLearnedAt = "level_learned_at"
            case moveLearnMethod = "move_learn_method"
            case versionGroup = "version_group"
        }
    }


    // MARK: - Sprites
    struct Sprites :Decodable {
        let backDefault: String?
        let backShiny: String?
        let frontDefault: String?
        let frontShiny: String?
        let other: Other?

        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case other
        }
        
    }


    // MARK: - Home
    struct Home:Decodable {
        let frontDefault: String?
        let frontShiny: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
        }
    }


    // MARK: - DreamWorld
    struct DreamWorld:Decodable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    // MARK: - Other
    struct Other:Decodable {
        let dreamWorld: DreamWorld?
        let home: Home?
        let officialArtwork: OfficialArtwork?
        
        enum CodingKeys: String, CodingKey {
            case dreamWorld = "dream_world"
            case home
            case officialArtwork = "official_artwork"
        }
    }

    // MARK: - OfficialArtwork
    struct OfficialArtwork:Decodable {
        let frontDefault: String?
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    // MARK: - Stat
    struct Stat:Decodable {
        let baseStat, effort: Int?
        let stat: Pairs?
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort
            case stat
        }
        
    }

    // MARK: - TypeElement
    struct TypeElement:Decodable {
        let slot: Int?
        let type: Pairs?
    }

}

