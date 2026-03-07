//
//  LoginViewModelTests.swift
//  TravelPlannerTests
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import XCTest
@testable import TravelPlanner

@MainActor
final class LoginViewModelTests: XCTestCase {

    func testValidateEmptyEmail() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = ""
        vm.password = "password1"
        XCTAssertEqual(vm.validate(), "Please fill in all fields.")
    }

    func testValidateEmptyPassword() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = ""
        XCTAssertEqual(vm.validate(), "Please fill in all fields.")
    }

    func testValidateInvalidEmail() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = "notanemail"
        vm.password = "password1"
        XCTAssertEqual(vm.validate(), "Please enter a valid email address.")
    }

    func testValidateShortPassword() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = "12345"
        XCTAssertEqual(vm.validate(), "Password must be at least 6 characters.")
    }

    func testValidateSuccess() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = "password1"
        XCTAssertNil(vm.validate())
    }

    func testValidateEmailWithSpaces() {
        let vm = LoginViewModel(authService: MockAuthService())
        vm.email = "  user@example.com  "
        vm.password = "password1"
        XCTAssertNil(vm.validate())
    }
}

private final class MockAuthService: AuthServicing {
    func register(email: String, password: String) async throws {}
    func login(email: String, password: String) async throws {}
    func logout() throws {}
    func isUserLoggedIn() -> Bool { false }
}
