//
//  DetailsInteractor.swift
//  CataPoke
//
//  Created by Emin on 4.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation


typealias DetailsInteractorCompletion = ((Result<CompleteDetailResponse, APIError>) -> Void)
final class DetailsInteractor {
    
    private var requestHandler: RequestHandling
    
    init(requestHandler: RequestHandling) {
        self.requestHandler = requestHandler
    }
}

// MARK: - Extensions -

extension DetailsInteractor: DetailsInteractorInterface {

    
    func getDetails(url:URL, completion: @escaping DetailsInteractorCompletion){
        requestHandler.request(route: .getSpecies(url)) { [weak self] (result:Result<SpeciesDetails, APIError>) in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let response):
                self.fetchEvolutionDetails(url: response.evolutionChain.url, specyDetail: response, completion: completion)
                
            case .failure(let err):
                //TODO: add error popups
                completion(.failure(err))
            }
        }
    }
    
    /// Fetches evolution details
    /// - Parameters:
    ///   - url: url to fetch evolution
    ///   - specyDetail: specy detail response model
    ///   - completion: completion
    private func fetchEvolutionDetails(url:URL,
                                       specyDetail: SpeciesDetails,
                                       completion: @escaping DetailsInteractorCompletion ){
        requestHandler.request(route: .getEvolutionChain(url)) { [weak self] (result:Result<EvolutionChainDetails, APIError>) in
            guard let self = self else {return}
            switch result {
                
            case .success(let evlotutionResponse):
             
                self.fetchPokemonDetails(pokemonId: specyDetail.id,
                                    specyDetail: specyDetail,
                                    evolutionDetails: evlotutionResponse) { result in
                    completion(result)
                }
                
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    private func fetchPokemonDetails(pokemonId:Int,
                                     specyDetail: SpeciesDetails,
                                     evolutionDetails:EvolutionChainDetails,
                                     completion: @escaping DetailsInteractorCompletion){
        
        
        requestHandler.request(route: .getPokemonDetails(id: pokemonId)) { [weak self] (result:Result<PokemonDetails, APIError>) in
            guard let self = self else {return}
            switch result {
                
            case .success(let detailsResponse):
                
                
                let mergedResponse = self.mergeResponses(specyDetails: specyDetail,
                                                         evolutionDetails: evolutionDetails,
                                                         pokemonDetails: detailsResponse)
                completion(.success(mergedResponse))
                
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    /// Merges given two responses and create simple response model for presenter
    /// - Parameters:
    ///   - specyDetails: specy details response model
    ///   - evolutionDetails: evolution details response model
    /// - Returns: CompleteDetailResponse that contains merged response
    private func mergeResponses(specyDetails: SpeciesDetails,
                                evolutionDetails: EvolutionChainDetails,
                                pokemonDetails:PokemonDetails) -> CompleteDetailResponse{
        
        var evolutionChain: [Species] = []
        
        self.flattenEvolutionChain(evolutionChain: &evolutionChain, chainLink: evolutionDetails.chain)
       
        // Obtain imageURL
        var imageUrl: URL?
        if let imageUrlStr = pokemonDetails.sprites?.other?.home?.frontDefault {
            imageUrl = URL(string: imageUrlStr)
        }
        
        return CompleteDetailResponse(name: specyDetails.name,
                                                  id: specyDetails.id,
                                                  imageURL: imageUrl,
                                                  color: specyDetails.color.name,
                                                  abilities: flattenAbilities(pokemonDetails: pokemonDetails),
                                                  height: pokemonDetails.height,
                                                  weight: pokemonDetails.weight,
                                                  moves: flattenMoves(pokemonDetails: pokemonDetails),
                                                  stats: flattenStats(pokemonDetails: pokemonDetails),
                                                  types: flattenTypes(pokemonDetails: pokemonDetails),
                                                  habitat: specyDetails.habitat.name,
                                                  isMytical: specyDetails.isMytical,
                                                  isLegendary: specyDetails.isLegendary,
                                                  evolutionChain: evolutionChain)

        
    }
    
    /// Flattens given chain link
    /// - Parameters:
    ///   - evolutionChain: Evolotioun chain array
    ///   - chainLink: Given chain link
    private func flattenEvolutionChain(evolutionChain: inout [Species], chainLink: ChainLink){
        evolutionChain.append(chainLink.species)
        if !chainLink.evolvesTo.isEmpty{
            flattenEvolutionChain(evolutionChain: &evolutionChain,
                                  chainLink: chainLink.evolvesTo[0])
        }
    }
}

//MARK: - Response Utility Functions -
extension DetailsInteractor {
    
    
    /// This function merge and flatten flavor texts and store them in dictionary which uses languges as keys.
    /// - Parameter specyDetails: SpeciesDetails Reponse
    /// - Returns: Dictionary that contains all flavor texts divided by languages
    private func flattenFlavorTexts(specyDetails:SpeciesDetails) -> Dictionary<String,[String]> {
        var flavorTexts:Dictionary<String,[String]> = [:]
        if let flavorArr = specyDetails.flavorTextEntries{
            
            flavorArr.forEach { element in
                
                if let language = element.language?.name, let value = element.flavorText {
                    
                    if let arr = flavorTexts[language]{
                        var newArr = arr
                        newArr.append(value)
                        flavorTexts[language] = newArr
                    }else {
                        flavorTexts[language] = [value]
                    }
                    
                    
                }
            }
        }
        return flavorTexts
    }
    
    /// This function combines all abilities in a single array.
    /// - Parameter pokemonDetails: PokemonDetails response
    /// - Returns: String array that contains abilitites
    private func flattenAbilities(pokemonDetails:PokemonDetails) -> [String]{
        // Flatten abilities to single String array
        var abilities:[String] = []
        if let abilitiesArr = pokemonDetails.abilities{
            abilities = abilitiesArr.compactMap { element in
                return element.ability?.name
            }
        }
        return abilities
    }
    
    /// This function combines all moves in a single array.
    /// - Parameter pokemonDetails: PokemonDetails response
    /// - Returns: String array that contains moves
    private func flattenMoves(pokemonDetails:PokemonDetails) -> [String]{
        // Flatten moves to single String array
        var moves:[String] = []
        if let movesArr = pokemonDetails.moves{
            moves = movesArr.compactMap({ element in
                return element.move?.name
            })
        }
        return moves
    }
    
    /// This function combines all types in a single array.
    /// - Parameter pokemonDetails: PokemonDetails response
    /// - Returns: String array that contains moves
    private func flattenTypes(pokemonDetails:PokemonDetails) -> [String]{
        // Flatten types to single String array
        var types:[String] = []
        if let typesArr = pokemonDetails.types{
            types = typesArr.compactMap({ element in
                return element.type?.name
            })
        }
        return types
    }
    
    /// This function combines all stats in a single dictionary.
    /// - Parameter pokemonDetails: PokemonDetails response
    /// - Returns: Dictionary that contains stats
    private func flattenStats(pokemonDetails:PokemonDetails) -> Dictionary<String, Int>{
        // Flatten stats to single dictionary
        var stats:Dictionary<String, Int> = [:]
        if let statsArr = pokemonDetails.stats{
            statsArr.forEach { element in
                if let name = element.stat?.name, let value = element.baseStat{
                    stats[name] = value
                }
            }
        }
        return stats
    }
    
    
}


struct CompleteDetailResponse {
    let name: String
    let id : Int
    let imageURL: URL?
    let color: String
    let abilities:[String]
    let height:Int?
    let weight:Int?
    let moves: [String]
    let stats: Dictionary<String, Int>
    let types: [String]
    let habitat: String
    let isMytical: Bool
    let isLegendary : Bool
    let evolutionChain : [Species]
}
