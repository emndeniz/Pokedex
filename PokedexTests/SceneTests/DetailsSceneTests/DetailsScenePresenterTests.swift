//
//  DetailsScenePresenterTests.swift
//  PokedexTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest
@testable import Pokedex


final class DetailsScenePresenterTests: XCTestCase {
    
    
    private var mockWireFrame: MockWireframe!
    private var mockInteractor: MockInteractor!
    private var mockView: MockView!
    
    var sut: DetailsPresenter!
    
    override func setUpWithError() throws {
        mockView = MockView()

        let response = generateDetailsResponse()
        mockInteractor = MockInteractor(response)
        mockWireFrame = MockWireframe()
        sut = DetailsPresenter(view: mockView,
                            interactor: mockInteractor,
                               wireframe: mockWireFrame,
                               specyURL: URL(string: "https://pokeapi.co/api/v2/pokemon-species/1/")!)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockWireFrame = nil
    }
    
    func test_GivenDetailsExist_WhenGetPokemonsCalled_ThenExpectedToHaveCorrectData() throws {
        
        let expectedResponse = generateDetailsResponse()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockView.updateUICalled,"Update view should called")
        XCTAssertFalse(mockView.dismissViewCalled,"Dismiss view should not called")
        
        
        XCTAssertEqual(mockView.model?.name, expectedResponse.name, "Name not matching")
        XCTAssertEqual(mockView.model?.weight, expectedResponse.weight, "weight not matching")
        XCTAssertEqual(mockView.model?.height, expectedResponse.height, "height not matching")
        XCTAssertEqual(mockView.model?.habitat, expectedResponse.habitat, "habitat not matching")
        XCTAssertEqual(mockView.model?.color, expectedResponse.color, "color not matching")
        XCTAssertEqual(mockView.model?.id, expectedResponse.id, "id not matching")
        XCTAssertEqual(mockView.model?.moves[0], expectedResponse.moves[0], "moves not matching")
        XCTAssertEqual(mockView.model?.types, expectedResponse.types, "types not matching")
        XCTAssertEqual(mockView.model?.imageURL?.absoluteString, expectedResponse.imageURL?.absoluteString, "imageURL not matching")
        XCTAssertEqual(mockView.model?.evolutionChain.count, expectedResponse.evolutionChain.count, "evolutionChain not matching")

        XCTAssertEqual(mockView.model?.isMytical, mockView.model?.isMytical,"isMytical not matching")
        XCTAssertEqual(mockView.model?.isLegendary, mockView.model?.isLegendary,"isLegendary not matching")
       
    }
    
    func test_GivenDetailsNotExist_WhenGetPokemonsCalled_ThenExpectedToHaveError() throws {
        
        
        mockInteractor.detailsResponse = nil
        mockInteractor.isReturnFailure = true

        sut.viewDidLoad()
        
        XCTAssertFalse(mockView.updateUICalled,"Update UI should not called")
        XCTAssertTrue(mockWireFrame.isShowAlertCalled,"Alert should be called")
        
        XCTAssertEqual(mockWireFrame.alertTitle, "errorOoops".localized, "Alert title not matching")
        XCTAssertEqual(mockWireFrame.alertMessage, "failedToFetchDataMessage".localized, "Alert message not matching")
      
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
                                      isLegendary: true,
                                      evolutionChain: evolutionChain)
}




private class MockView : DetailsViewInterface {
    var updateUICalled = false
    var dismissViewCalled = false
    var model: CompleteDetailResponse?
    
    func updateUI(model: Pokedex.CompleteDetailResponse) {
        updateUICalled = true
        self.model = model
    }
    
    func dismissView() {
        dismissViewCalled = true
    }
}


private class MockWireframe: DetailsWireframeInterface {
    
    var isShowAlertCalled = false
    var alertMessage: String?
    var alertTitle:String?
    
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

    private class MockInteractor: DetailsInteractorInterface {
        
        var detailsResponse : CompleteDetailResponse?
        var isReturnFailure: Bool
        
        init(_ detailsResponse: CompleteDetailResponse?, _ isReturnFailure:Bool = false){
            self.detailsResponse = detailsResponse
            self.isReturnFailure = isReturnFailure
        }
        
        func getDetails(url: URL, completion: @escaping Pokedex.DetailsInteractorCompletion) {
            if isReturnFailure {
                completion(.failure(.invalidData))
            }else {
                completion(.success(detailsResponse!))
            }
        }
        
    }
    
}
