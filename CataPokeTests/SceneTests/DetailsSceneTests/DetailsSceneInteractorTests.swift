//
//  DetailsSceneInteractorTests.swift
//  CataPokeTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import CataPoke

final class DetailsSceneInteractorTests: XCTestCase {
    
    
    private var mockRequestHandler: MockRequestHandler!
    private var expectation: XCTestExpectation!
    
    private var sut: DetailsInteractor!
    
    private let requestURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/4/")!
    
    private var sampleSpecyDetailsResponse:SpeciesDetails {
        let specyDetails = JSONTestHelper().readAndDecodeFile(decodeType: SpeciesDetails.self, name: "CharizardSpecyDetails")
        return specyDetails
    }
    
    private var samplePokemonDetailsResponse:PokemonDetails {
        let specyDetails = JSONTestHelper().readAndDecodeFile(decodeType: PokemonDetails.self, name: "CharizardPokemonDetails")
        return specyDetails
    }
    
    private var sampleEvolutionChainResponse:EvolutionChainDetails {
        let specyDetails = JSONTestHelper().readAndDecodeFile(decodeType: EvolutionChainDetails.self, name: "CharizardEvolutionChain")
        return specyDetails
    }
    
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        mockRequestHandler = MockRequestHandler()
        sut = DetailsInteractor(requestHandler: mockRequestHandler)
        expectation = expectation(description: "Expectation")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockRequestHandler = nil
        expectation = nil
    }
    
    func test_GivenAppHasSuccessfullDetailsResponses_WhenGetDetailsCalled_ThenExpectingToSeeSuccessfullData() throws {
        // Get Sample datas
        mockRequestHandler.speciesDetailsResponse = sampleSpecyDetailsResponse
        mockRequestHandler.pokemonDetailsResponse = samplePokemonDetailsResponse
        mockRequestHandler.evolutionChainResponse = sampleEvolutionChainResponse
        
        let expectedResponse = generateDetailsResponse()
        sut.getDetails(url: requestURL) { (result:Result<CompleteDetailResponse, APIError>) in
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response.name, expectedResponse.name, "Name not matching")
                XCTAssertEqual(response.weight, expectedResponse.weight, "Name not matching")
                XCTAssertEqual(response.height, expectedResponse.height, "Name not matching")
                XCTAssertEqual(response.habitat, expectedResponse.habitat, "Name not matching")
                XCTAssertEqual(response.color, expectedResponse.color, "Name not matching")
                XCTAssertEqual(response.id, expectedResponse.id, "Name not matching")
                XCTAssertEqual(response.moves[0], expectedResponse.moves[0], "Name not matching")
                XCTAssertEqual(response.types, expectedResponse.types, "Name not matching")
                XCTAssertEqual(response.imageURL?.absoluteString, expectedResponse.imageURL?.absoluteString, "Name not matching")
                XCTAssertEqual(response.evolutionChain.count, expectedResponse.evolutionChain.count, "Name not matching")
            case .failure(let err):
                XCTFail("Error was not expected: \(err.localizedDescription)")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_GivenAppHasFailOnSpecyDetailsResponses_WhenGetDetailsCalled_ThenExpectingToFail() throws {
        // Get Sample datas
        mockRequestHandler.speciesDetailsResponse = nil
        mockRequestHandler.pokemonDetailsResponse = samplePokemonDetailsResponse
        mockRequestHandler.evolutionChainResponse = sampleEvolutionChainResponse
        mockRequestHandler.isReturnFailureToSpecyDetails = true
        
        let expectedResponse = generateDetailsResponse()
        sut.getDetails(url: requestURL) { (result:Result<CompleteDetailResponse, APIError>) in
            switch result {
                
            case .success(let response):
                XCTFail("Success was not expected")
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, APIError.invalidData.localizedDescription)
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_GivenAppHasFailOnEvolutionChainResponses_WhenGetDetailsCalled_ThenExpectingToFail() throws {
        // Get Sample datas
        mockRequestHandler.speciesDetailsResponse = sampleSpecyDetailsResponse
        mockRequestHandler.pokemonDetailsResponse = samplePokemonDetailsResponse
        mockRequestHandler.evolutionChainResponse = nil
        mockRequestHandler.isReturnFailureToEvolutionChain = true
        
        let expectedResponse = generateDetailsResponse()
        sut.getDetails(url: requestURL) { (result:Result<CompleteDetailResponse, APIError>) in
            switch result {
                
            case .success(let response):
                XCTFail("Success was not expected")
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, APIError.invalidData.localizedDescription)
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_GivenAppHasFailOnPokemonDetailsResponses_WhenGetDetailsCalled_ThenExpectingToFail() throws {
        // Get Sample datas
        mockRequestHandler.speciesDetailsResponse = sampleSpecyDetailsResponse
        mockRequestHandler.pokemonDetailsResponse = nil
        mockRequestHandler.evolutionChainResponse = sampleEvolutionChainResponse
        mockRequestHandler.isReturnFailureToEvolutionChain = true
        
        let expectedResponse = generateDetailsResponse()
        sut.getDetails(url: requestURL) { (result:Result<CompleteDetailResponse, APIError>) in
            switch result {
                
            case .success(let response):
                XCTFail("Success was not expected")
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, APIError.invalidData.localizedDescription)
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    
    /// Genereates sample response to compare
    /// - Returns:CompleteDetailResponse
    private func generateDetailsResponse() -> CompleteDetailResponse{
        
        let abilities = ["blaze","solar-power"]
        let moves = ["mega-punch", "fire-punch"]
        let stats: Dictionary<String,Int> = ["defense":  78, "hp": 78 , "pecial-attack": 109 ]
        let types = ["fire","flying"]
        let evolutionChain: [Species] = [
            Species(name: "charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon-species/4/")!),
            Species(name: "charmeleon", url: URL(string: "https://pokeapi.co/api/v2/pokemon-species/5/")!),
            Species(name: "charizard", url: URL(string: "https://pokeapi.co/api/v2/pokemon-species/6/")!)
        ]
        
        return CompleteDetailResponse(name: "charizard",
                                      id: 6,
                                      imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/6.png"),
                                      color: "red",
                                      abilities: abilities,
                                      height: 17,
                                      weight: 905,
                                      moves: moves,
                                      stats: stats,
                                      types: types,
                                      habitat: "mountain",
                                      isMytical: false,
                                      isLegendary: false,
                                      evolutionChain: evolutionChain)
    }
}

private class MockRequestHandler : RequestHandling{
    
    var speciesDetailsResponse : SpeciesDetails?
    var evolutionChainResponse : EvolutionChainDetails?
    var pokemonDetailsResponse : PokemonDetails?
    var isReturnFailureToSpecyDetails: Bool
    var isReturnFailureToPokemonDetails: Bool
    var isReturnFailureToEvolutionChain: Bool
    
    init(_ speciesDetailsResponse: SpeciesDetails? = nil,
         _ evolutionChainResponse: EvolutionChainDetails? = nil,
         _ pokemonDetailsResponse: PokemonDetails? = nil,
         _ isReturnFailureToSpecyDetails:Bool = false,
         _ isReturnFailureToPokemonDetails:Bool = false,
         _ isReturnFailureToEvolutionChain:Bool = false){
        self.speciesDetailsResponse = speciesDetailsResponse
        self.evolutionChainResponse = evolutionChainResponse
        self.pokemonDetailsResponse = pokemonDetailsResponse
        self.isReturnFailureToSpecyDetails = isReturnFailureToSpecyDetails
        self.isReturnFailureToPokemonDetails = isReturnFailureToPokemonDetails
        self.isReturnFailureToEvolutionChain = isReturnFailureToEvolutionChain
    }
    
    func request<T>(route: CataPoke.APIRoute, completion: @escaping (Result<T, CataPoke.APIError>) -> Void) where T : Decodable {
        
        switch route {
        case .getSpeciesList(limit: _ , offset: _):
            fatalError("This shouldn't be called in detail scene")
        case .getSpecies(_):
            if isReturnFailureToSpecyDetails {
                completion(.failure(.invalidData))
            }else {
                completion(.success(speciesDetailsResponse as! T))
            }
        case .getEvolutionChain(_):
            if isReturnFailureToEvolutionChain {
                completion(.failure(.invalidData))
            }else {
                completion(.success(evolutionChainResponse as! T))
            }
        case .getPokemonDetails(id: _):
            if isReturnFailureToPokemonDetails {
                completion(.failure(.invalidData))
            }else {
                completion(.success(pokemonDetailsResponse as! T))
            }
        }
        
        
    }
    
    
}
