//
//  EditProductView_UnitTests.swift
//  ImpetusTests
//
//  Created by Harshal Kulkarni on 02/05/22.
//

import XCTest
@testable import Impetus
import SwiftUI


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then


class EditProductView_UnitTests: XCTestCase {

    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_EditProductView_productId_shouldBeSameAsTheParameterPassed() {
        let product = Product(id: 1, title: "Title", price: 100, description: "Desc", category: "Category", image: "https://demolink.com")
        @State var data: [Product] = []
        
        let EPView = EditProductView(product: product, data: $data)
        
        XCTAssertEqual(EPView.product, product)
    }
}
