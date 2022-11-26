//
//  ListPresenterTests.swift
//  PokedexTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import Pokedex

final class ListPresenterTests: XCTestCase {

    
    private var mockWireFrame: MockWireframe!
    private var mockInteractor: MockInteractor!
    private var mockView: MockView!
    
    var sut: ListPresenter!
    
    override func setUpWithError() throws {
        mockView = MockView()
        let defaultSpeciesList = JSONTestHelper().readAndDecodeFile(decodeType: SpeciesResponse.self, name: "PokeList")
    
        mockInteractor = MockInteractor(defaultSpeciesList)
        mockWireFrame = MockWireframe()
        sut = ListPresenter(view: mockView,
                              interactor: mockInteractor,
                              wireframe: mockWireFrame)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockWireFrame = nil
    }

    
    func test_GivenSpeciesListExist_WhenGetPokemonsCalled_ThenExpectedToHaveCorrectData() throws {
        
        XCTAssertEqual(sut.pageNum,0,"Page num should be zero before sending any request")
        
        sut.getNewPokemons()

        XCTAssertTrue(mockView.refrestListCalled,"Navigate Fucntion should be called")
        XCTAssertFalse(mockWireFrame.isShowAlertCalled, "Alert should not be called")
        
        
        XCTAssertEqual(sut.species.count, 50, "There should be 50 species")
        XCTAssertEqual(sut.numberOfCells, 50, "There should be 50 cell")
        XCTAssertEqual(sut.cellForRowIndex(index: 0).name,"bulbasaur","Expected cell data not received")
        XCTAssertEqual(sut.cellForRowIndex(index: 0).url,
                       URL(string: "https://pokeapi.co/api/v2/pokemon-species/1/")!,"Expected cell data not received")
        XCTAssertEqual(sut.pageNum, 1 , "Page num should be incremented after fetch")
    }
    
    
    
    func test_GivenSpeciesListDoesntExist_WhenGetPokemonsCalled_ThenExpectedToHaveAlert() throws {
        
        XCTAssertEqual(sut.pageNum,0,"Page num should be zero before sending any request")
        
        mockInteractor.speciesResponse = nil
        mockInteractor.isReturnFailure = true
        
        sut.getNewPokemons()

        XCTAssertFalse(mockView.refrestListCalled,"Navigate Fucntion should not be called")
        XCTAssertTrue(mockWireFrame.isShowAlertCalled, "Alert should be called")
        
        
        XCTAssertEqual(sut.species.count, 0, "There should be 0 species")
        XCTAssertEqual(sut.numberOfCells, 0, "There should be 0 cell")
        XCTAssertEqual(mockWireFrame.alertTitle, "errorOoops".localized, "Alert title not matched")
        XCTAssertEqual(mockWireFrame.alertMessage, "failedToFetchDataMessage".localized, "Alert message not matched")
    }
    
    
    func test_GivenSpeciesListExist_WhenDidSelectRowCalled_ThenExpectedToNavigateToDetails() throws {
        
        
        sut.getNewPokemons()

        XCTAssertTrue(mockView.refrestListCalled,"Navigate Fucntion should be called")
        XCTAssertFalse(mockWireFrame.isShowAlertCalled, "Alert should not be called")
        
        
        sut.didSelectRow(index: 0)
        
        XCTAssert(mockWireFrame.isNavigateFunctionCalled,"Navigataion should be called")
        XCTAssertEqual(mockWireFrame.specyUrl, URL(string: "https://pokeapi.co/api/v2/pokemon-species/1/")!, "URL not matching")
        
    }
    
    
    
}

private class MockView : ListViewInterface {
    var refrestListCalled = false
    var dismissIndicatorCalled = false
    var dismissAlertCalled = false
    func refreshList() {
        refrestListCalled = true
    }
    
    func dismissIndicator() {
        dismissIndicatorCalled = true
    }
    
    func dismissAlert() {
        dismissAlertCalled = true
    }
    

    
}


private class MockWireframe: ListWireframeInterface {


    var isNavigateFunctionCalled = false
    var isShowAlertCalled = false
    
    var specyUrl: URL?
    var alertMessage: String?
    var alertTitle:String?
    
    func navigateToDetails(specyURL:URL){
        self.specyUrl = specyURL
        isNavigateFunctionCalled = true
    }
    
    func showAlert(with title: String?, message: String?, completion: (() -> Void)?) {
        isShowAlertCalled = true
        self.alertMessage = message
        self.alertTitle = title
    }
    
    func showAlert(with title: String?, message: String?, actions: [Pokedex.Action]) {
        isShowAlertCalled = true
        self.alertMessage = message
        self.alertTitle = title
    }
}

private class MockInteractor: ListInteractorInterface {
    
    var speciesResponse : SpeciesResponse?
    var isReturnFailure: Bool
    
    init(_ speciesResponse: SpeciesResponse?, _ isReturnFailure:Bool = false){
        self.speciesResponse = speciesResponse
        self.isReturnFailure = isReturnFailure
    }
    
    
    func getSpeciesList(pageNum: Int, _ completion: @escaping ((Result<Pokedex.SpeciesResponse, Pokedex.APIError>) -> Void)) {
        if isReturnFailure {
            completion(.failure(.invalidData))
        }else {
            completion(.success(speciesResponse!))
        }
    }
    
    
}
