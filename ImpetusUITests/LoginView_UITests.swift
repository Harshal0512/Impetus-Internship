//
//  LoginView_UITests.swift
//  ImpetusUITests
//
//  Created by Harshal Kulkarni on 01/05/22.
//

import XCTest


// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then



class LoginView_UITests: XCTestCase {
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
        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }
        
        let loginNavBarTitle = app.staticTexts["Sign In"]
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
        let email = app.textFields["Email Address"]
        XCTAssert(email.exists)
         
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        
        let login = app.buttons["Sign In"]
        XCTAssert(login.exists)
        XCTAssertEqual(login.label, "Sign In")
        
        XCTAssertTrue(app.buttons["Click here to Sign Up"].exists)
    }
    
    func test_LoginView_signInButton_shouldSignIn() {
        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }
        
        let email = app.textFields["Email Address"]
        let login = app.buttons["Sign In"]
        
        email.tap()
        email.typeText("harshal@gmail.com")
            
        XCTAssertNotEqual(email.value as! String, "")
        XCTAssertEqual(email.value as! String, "harshal@gmail.com")
        
        app.secureTextFields.element.tap()
        app.secureTextFields.element.typeText("password")

        XCTAssertNotEqual(app.secureTextFields.element.value as! String, "")
        
        login.tap()
        XCTAssertFalse(login.waitForExistence(timeout: 5))
    }
}
