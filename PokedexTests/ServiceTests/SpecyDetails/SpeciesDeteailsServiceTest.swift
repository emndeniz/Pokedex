//
//  SpeciesDeteailsTest.swift
//  PokedexTests
//
//  Created by Emin on 8.11.2022.
//

import XCTest
@testable import Pokedex

final class SpeciesDeteailsServiceTest: XCTestCase {
    
    
    var requestHandler: RequestHandling!
    var expectation: XCTestExpectation!
    
    let apiURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/4/?")!
    
    
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
        
        let data = JSONTestHelper().readLocalFile(name: "SpecyDetailsResponse")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw fatalError("URLS are not matching")
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let URL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/4/")!
        requestHandler.request(route: .getSpecies(URL)) {(result: Result<SpeciesDetails, APIError>) in
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response.name, "charmander", "Pokemon name not matching")
                XCTAssertEqual(response.color.name, "red", "Color name not matching")
                XCTAssertEqual(response.habitat.name, "mountain", "Habitat name is not matching")
                XCTAssertEqual(response.evolutionChain.url.absoluteString, "https://pokeapi.co/api/v2/evolution-chain/2/", "Evolution chain url is not matching")
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
        
        let URL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/4/")!
        requestHandler.request(route: .getSpecies(URL)) {(result: Result<SpeciesDetails, APIError>) in
            
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
