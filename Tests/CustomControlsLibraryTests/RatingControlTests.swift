//
//  RatingControlTests.swift
//  
//
//  Created by Aldair Cosetito Coral on 18/06/22.
//

import XCTest
@testable import CustomControlsLibrary

@available(iOS 13.0, *)
class RatingControlTests: XCTestCase {

    var ratingControl: RatingControl?
    let size = 5
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        ratingControl = nil
    }
    
    func testCreateRatingControl() throws {
        ratingControl = RatingControl(size: size, value: 0)
        XCTAssertNotNil(ratingControl)
        let container = try XCTUnwrap(ratingControl?.contentStackView.arrangedSubviews)
        XCTAssertEqual(container.count, size)
        //XCTAssert(<#T##expression: Bool##Bool#>, <#T##message: String##String#>)
    }
    
    func testGetValue() throws {
        ratingControl = RatingControl(size: size, value: 2)
        let value = try XCTUnwrap(ratingControl?.value)
        
    }
}
