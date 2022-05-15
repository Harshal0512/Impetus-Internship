//
//  ListView_UITests.swift
//  ImpetusUITests
//
//  Created by Harshal Kulkarni on 06/05/22.
//

import XCTest


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then



class ListView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func login() {
        let email = app.textFields["Email Address"]
        let login = app.buttons["Sign In"]
        
        email.tap()
        email.typeText("harshal@gmail.com")
        
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("password")
        
        login.tap()
        XCTAssertFalse(login.waitForExistence(timeout: 5))
    }
    
    func test_ListView_Appearance() {
        if !app.buttons["Logout"].exists {
            login()
        }
        
        XCTAssertTrue(app.buttons["Logout"].exists)
        XCTAssertTrue(app.buttons["Edit"].exists)
        XCTAssertTrue(app.buttons["Add Product"].exists)
        XCTAssertTrue(app.navigationBars.element.exists)
        XCTAssertTrue(app.tables.cells.element.exists)
    }
}
