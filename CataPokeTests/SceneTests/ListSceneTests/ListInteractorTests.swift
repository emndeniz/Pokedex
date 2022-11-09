//
//  ListInteractorTests.swift
//  CataPokeTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import CataPoke

final class ListInteractorTests: XCTestCase {

    var mockRequestHandler: MockRequestHandler!
    var expectation: XCTestExpectation!
    
    private var sut: ListInteractor!
    
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        mockRequestHandler = MockRequestHandler()
        sut = ListInteractor(requestHandler: mockRequestHandler)
        expectation = expectation(description: "Expectation")
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRequestHandler = nil
        expectation = nil
    }

    func test_GivenAppHasSuccessfullListResponses_WhenGetSpeciesListCalled_ThenExpectingToSeeSuccessfullData() throws {
        // Get Sample data
        let speciesList = JSONTestHelper().readAndDecodeFile(decodeType: SpeciesResponse.self, name: "PokeList")
        mockRequestHandler.speciesResponse = speciesList
        
        sut.getSpeciesList(pageNum: 0) { (result:Result<SpeciesResponse, APIError>) in
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response.count, 905, "Total number of specises should be 905")
                XCTAssertEqual(response.results.count, 50, "There should be 50 element in response")
                XCTAssertEqual(response.results[0].name, "bulbasaur", "Pokemon name is not matching")
                XCTAssertEqual(response.results[0].url.absoluteString, "https://pokeapi.co/api/v2/pokemon-species/1/", "Species url is not matching")
            case .failure(let err):
                XCTFail("Error was not expected: \(err.localizedDescription)")
            }
            
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }


    func test_GivenAppHasFailSpeciesListResponses_WhenGetSpeciesListCalled_ThenExpectingToSeeError() throws {
        mockRequestHandler.isReturnFailure = true
        
        
        sut.getSpeciesList(pageNum: 0) { (result:Result<SpeciesResponse, APIError>) in
            switch result {
                
            case .success(_):
                XCTFail("Success was not expected")
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, APIError.invalidData.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        
    }
    
    
}

class MockRequestHandler : RequestHandling{
    
    var speciesResponse : SpeciesResponse?
    var isReturnFailure: Bool
    
    init(_ speciesResponse: SpeciesResponse? = nil, _ isReturnFailure:Bool = false){
        self.speciesResponse = speciesResponse
        self.isReturnFailure = isReturnFailure
    }
    
    func request<T>(route: CataPoke.APIRoute, completion: @escaping (Result<T, CataPoke.APIError>) -> Void) where T : Decodable {
        if isReturnFailure {
            completion(.failure(.invalidData))
        }else {
            completion(.success(speciesResponse as! T))
        }
    }
    
    
}
