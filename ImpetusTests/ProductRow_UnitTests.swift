//
//  ProductRow_UnitTests.swift
//  ImpetusTests
//
//  Created by Harshal Kulkarni on 01/05/22.
//

import XCTest
@testable import Impetus


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then


class ProductRow_UnitTests: XCTestCase {

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
    
    func test_ProductRow_prodID_shouldBeSameAsTheParameterPassed() {
        let product = Product(id: 1, title: "Title", price: 100, description: "Desc", category: "Category", image: "https://demolink.com")
        
        let prod = ProductRow(product: product)
        
        XCTAssertNotNil(prod.product)
        XCTAssertEqual(prod.product, product)
        XCTAssertEqual(prod.prodID, product.id)
    }

}
