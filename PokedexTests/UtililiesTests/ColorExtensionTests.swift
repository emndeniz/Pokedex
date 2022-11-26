//
//  ColorExtensionTests.swift
//  PokedexTests
//
//  Created by Emin on 9.11.2022.
//

import XCTest

@testable import Pokedex

final class ColorExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckAllExistingColorsAreNotNil() throws {
        let collorArray = ["black","blue","brown","gray", "green","pink","purple", "red","white","yellow"]

        for element in collorArray {
            // This also ensures force casting not causing any crash
            let color = UIColor.getMatchingColor(colorName: element)
            
            XCTAssertNotNil(color, "Color should not be nil")
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
