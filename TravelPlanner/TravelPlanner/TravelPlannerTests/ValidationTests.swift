//
//  ValidationTests.swift
//  TravelPlannerTests
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import XCTest
@testable import TravelPlanner

final class ValidationTests: XCTestCase {

    func testValidEmails() {
        XCTAssertTrue("a@b.co".isValidEmail)
        XCTAssertTrue("user@example.com".isValidEmail)
        XCTAssertTrue("user.name+tag@example.co.uk".isValidEmail)
        XCTAssertTrue("UPPER@DOMAIN.COM".isValidEmail)
    }

    func testInvalidEmails() {
        XCTAssertFalse("".isValidEmail)
        XCTAssertFalse("plain".isValidEmail)
        XCTAssertFalse("@domain.com".isValidEmail)
        XCTAssertFalse("user@".isValidEmail)
        XCTAssertFalse("user@domain".isValidEmail)
        XCTAssertFalse("user name@domain.com".isValidEmail)
    }
}
