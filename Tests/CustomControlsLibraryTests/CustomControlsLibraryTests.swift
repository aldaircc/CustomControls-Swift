import XCTest
@testable import CustomControlsLibrary

final class CustomControlsLibraryTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let materialTextField = MaterialTextField(placeHolderText: "ejemplo", activationColor: .red)
        materialTextField.placeHolderAnimation()
        
        XCTAssertEqual(CustomControlsLibrary().text, "Hello, World!")
    }
}
