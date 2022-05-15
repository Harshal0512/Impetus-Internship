//
//  SignUpView_UITests.swift
//  ImpetusUITests
//
//  Created by Harshal Kulkarni on 06/05/22.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then


class SignUpView_UITests: XCTestCase {
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
    
    func test_SignUpView_Appearance() {
        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }
        
        app.buttons["Click here to Sign Up"].tap()
        
        let loginNavBarTitle = app.staticTexts["Sign Up"]
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 3))
        let email = app.textFields["Email Address"]
        XCTAssert(email.exists)
         
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        
        let signup = app.buttons["Sign Up"]
        XCTAssert(signup.exists)
        XCTAssertEqual(signup.label, "Sign Up")
    }
}
