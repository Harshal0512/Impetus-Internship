//
//  AddProductView_UITests.swift
//  ImpetusUITests
//
//  Created by Harshal Kulkarni on 08/05/22.
//

import XCTest


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then



class AddProductView_UITests: XCTestCase {
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
    
    func test_LoginView_Appearance() {
        if !app.buttons["Logout"].exists {
            login()
        }
        
        let addProductButton = app.staticTexts["Add Product"]
        XCTAssert(addProductButton.waitForExistence(timeout: 5))
        
        addProductButton.tap()
        
        let addProductNavBarTitle = app.staticTexts["Add Product"]
        XCTAssert(addProductNavBarTitle.waitForExistence(timeout: 3))
        
        XCTAssert(app.textFields.element(boundBy: 0).exists)
        XCTAssert(app.textFields.element(boundBy: 1).exists)
        XCTAssert(app.textFields.element(boundBy: 2).exists)
        XCTAssert(app.textFields.element(boundBy: 3).exists)
        XCTAssert(app.textViews.element(boundBy: 0).exists)
        
//        let loginNavBarTitle = app.staticTexts["Sign In"]
//        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
//        let email = app.textFields["Email Address"]
//        XCTAssert(email.exists)
//
//        let password = app.secureTextFields["Password"]
//        XCTAssert(password.exists)
//
//        let login = app.buttons["Sign In"]
//        XCTAssert(login.exists)
//        XCTAssertEqual(login.label, "Sign In")
//
//        XCTAssertTrue(app.buttons["Click here to Sign Up"].exists)
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
    
}
