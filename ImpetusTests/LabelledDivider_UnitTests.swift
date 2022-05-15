//
//  LabelledDivider_UnitTests.swift
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

class LabelledDivider_UnitTests: XCTestCase {

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
    
    func test_LabelledDividor_label_shouldBeSameAsTheParameterPassed() {
        let labelString = "Label 1"
        
        let label = LabelledDivider(label: labelString)
        
        XCTAssertEqual(label.label, labelString)
    }
    
    func test_LabelledDividor_horizontalPadding_shouldNotBeEmpty() {
        let labelString = "Label 1"
        
        let label = LabelledDivider(label: labelString)
        
        XCTAssertNotNil(label.horizontalPadding)
    }
    
    func test_LabelledDividor_horizontalPadding_shouldBeTwenty() {
        let labelString = "Label 1"
        
        let label = LabelledDivider(label: labelString)
        
        XCTAssertEqual(label.horizontalPadding, 20)
    }
    
    func test_LabelledDividor_horizontalPadding_shouldBeSameAsTheParameterPassed() {
        let labelString = "Label 1"
        let horizontalPadding: CGFloat = 50
        
        let label = LabelledDivider(label: labelString, horizontalPadding: horizontalPadding)
        
        XCTAssertEqual(label.horizontalPadding, horizontalPadding)
    }
    
    func test_LabelledDividor_color_shouldBeGray() {
        let labelString = "Label 1"
        let horizontalPadding: CGFloat = 50
        
        let label = LabelledDivider(label: labelString, horizontalPadding: horizontalPadding)
        
        XCTAssertEqual(label.color, .gray)
    }
    
    func test_LabelledDividor_color_shouldBeSameAsParameterPassed() {
        let labelString = "Label 1"
        let horizontalPadding: CGFloat = 50
        let color: Color = .green
        
        let label = LabelledDivider(label: labelString, horizontalPadding: horizontalPadding, color: color)
        
        XCTAssertEqual(label.color, color)
    }

}
