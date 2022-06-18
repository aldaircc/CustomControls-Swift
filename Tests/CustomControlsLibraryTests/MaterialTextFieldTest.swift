//
//  MaterialTextFieldTest.swift
//  
//
//  Created by Aldair Cosetito Coral on 17/06/22.
//

import XCTest
@testable import CustomControlsLibrary

class MaterialTextFieldTest: XCTestCase {

    var materialTextField: MaterialTextField!
    let text = "Testing textfield"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        materialTextField = MaterialTextField(placeHolderText: "Label", activationColor: .yellow)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        materialTextField = nil
    }
    
    func testSetValue() throws {
        materialTextField.setValue(text)
        let textFromMethod = try XCTUnwrap(materialTextField.getValue())
        XCTAssert(!textFromMethod.isEmpty)
        XCTAssertEqual(textFromMethod, text)
        XCTAssertFalse(!textFromMethod.contains(text))
    }
    
    func testGetValue() throws {
        materialTextField.textField.text = text
        let textFromControl = try XCTUnwrap(materialTextField.textField.text)
        let textFromMethod = try XCTUnwrap(materialTextField.getValue())
        XCTAssert(textFromControl.elementsEqual(textFromMethod), "TextFields don't have the same text")
    }
    
    func testDidBeginEditing() {
        let textField = materialTextField.textField
        let placeHolderStartPosition = materialTextField.placeHolder.center
        let indicatorColor = materialTextField.activationIndicator.backgroundColor
        materialTextField.textFieldDidBeginEditing(textField)
        let placeHolderCurrentPosition = materialTextField.placeHolder.center
        let currentIndicatorColor = materialTextField.activationIndicator.backgroundColor
        XCTAssert(placeHolderStartPosition != placeHolderCurrentPosition)
        XCTAssert(indicatorColor != currentIndicatorColor)
        XCTAssert(currentIndicatorColor == materialTextField.activationColor)
    }
    
    func testDidEndEditingWithText() {
        let textField = materialTextField.textField
        let firstPosPlaceholder = materialTextField.placeHolder.center
        let indicatorColor = materialTextField.activationIndicator.backgroundColor
        materialTextField.textFieldDidBeginEditing(textField)
        materialTextField.setValue(text)
        materialTextField.textFieldDidEndEditing(textField)
        let currentPosPlaceholder = materialTextField.placeHolder.center
        XCTAssert(firstPosPlaceholder != currentPosPlaceholder, "The position of placeholder are the same, it's incorrect.")
        XCTAssert(indicatorColor == .gray, "The indicator color have to be default color when it loses focus")
    }
    
    func testDidEndEditingWithOutText() {
        let textField = materialTextField.textField
        let firstPosPlaceholder = materialTextField.placeHolder.center
        let indicatorColor = materialTextField.activationIndicator.backgroundColor
        materialTextField.textFieldDidBeginEditing(textField)
        materialTextField.textFieldDidEndEditing(textField)
        let currentPosPlaceholder = materialTextField.placeHolder.center
        XCTAssert(firstPosPlaceholder.equalTo(currentPosPlaceholder), "The position of placeholder are not the same, it's incorrect.")
        XCTAssert(indicatorColor == .gray, "The indicator color have to be default color when it loses focus")
    }
}
