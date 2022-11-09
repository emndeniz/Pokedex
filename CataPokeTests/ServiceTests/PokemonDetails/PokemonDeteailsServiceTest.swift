//
//  PokemonDeteailsServiceTest.swift
//  CataPokeTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import CataPoke


final class PokemonDeteailsServiceTest: XCTestCase {


    var requestHandler: RequestHandling!
    var expectation: XCTestExpectation!
    
    let apiURL = URL(string: "https://pokeapi.co/api/v2/pokemon/7?")!
    
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        requestHandler = RequestHandler(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_givenSpeciesListRequest_whenResponseSuccessFull_thenShouldContainRquiredData() throws {
        
        let data = JSONTestHelper().readLocalFile(name: "PokemonDetailsResponse")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw fatalError("URLS are not matching")
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        
        requestHandler.request(route: .getPokemonDetails(id: 7)) { (result: Result<PokemonDetails, APIError>) in
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response.name, "squirtle", "Pokemon name not matching")
                XCTAssertEqual(response.abilities?.count, 2, "Ability count not matching")
                XCTAssertEqual(response.abilities?[0].ability?.name, "torrent", "Ability name is not matching")
                XCTAssertEqual(response.moves?.count, 99, "Moves count is not matching")
                XCTAssertEqual(response.moves?[0].move?.name, "mega-punch", "Move name is not matching")
                XCTAssertEqual(response.baseExperience, 63, "Move name is not matching")
                XCTAssertEqual(response.height, 5, "Height is not matching")
                XCTAssertEqual(response.weight, 90, "Weight is not matching")
                XCTAssertEqual(response.types?.count, 1, "Type count is not matching")
                XCTAssertEqual(response.types?[0].type?.name, "water", "Type name is not matching")
            case .failure(let error):
                XCTFail("Error was not expected: \(error.localizedDescription)")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_givenSpeciesListRequest_whenResponseFails_thenShouldReturnFail() throws {
        
        // For error case we can use empty data
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        requestHandler.request(route: .getPokemonDetails(id: 7)) { (result: Result<PokemonDetails, APIError>) in
            switch result {
                
            case .success(_):
                XCTFail("Success was not expected")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, APIError.jsonConversionFailure.localizedDescription)
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
