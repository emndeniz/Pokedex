//
//  EvolutionChainService.swift
//  CataPokeTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import CataPoke

final class EvolutionChainService: XCTestCase {


    var requestHandler: RequestHandling!
    var expectation: XCTestExpectation!
    
    let apiURL = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1?")!
    
    
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
    
    func test_givenEvoloutionRequest_whenResponseSuccessFull_thenShouldContainRquiredData() throws {
        
        let data = JSONTestHelper().readLocalFile(name: "EvolutionChainResponse")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw fatalError("URLS are not matching")
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let URL = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1")!
        requestHandler.request(route: .getEvolutionChain(URL)) { (result: Result<EvolutionChainDetails, APIError>) in
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response.chain.species.name, "bulbasaur", "First evolution name not matching")
                XCTAssertEqual(response.chain.evolvesTo[0].species.name, "ivysaur", "Second evolution name not matching")
                XCTAssertEqual(response.chain.evolvesTo[0].evolvesTo[0].species.name, "venusaur", "Third evolution name not matching")
            case .failure(let error):
                XCTFail("Error was not expected: \(error.localizedDescription)")
            }
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_givenEvoloutionRequest_whenResponseFails_thenShouldReturnFail() throws {
        
        // For error case we can use empty data
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        
        let URL = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1")!
        requestHandler.request(route: .getEvolutionChain(URL)) { (result: Result<EvolutionChainDetails, APIError>) in
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


