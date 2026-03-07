//
//  RegisterViewModelTests.swift
//  TravelPlannerTests
//
//  Created by Chichak Badalbayli on 2/25/26.
//

import XCTest
@testable import TravelPlanner

@MainActor
final class RegisterViewModelTests: XCTestCase {

    func testValidateEmptyFields() {
        let vm = RegisterViewModel(authService: MockAuthService())
        vm.email = ""
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertEqual(vm.validate(), "Please fill in all fields.")
    }

    func testValidateInvalidEmail() {
        let vm = RegisterViewModel(authService: MockAuthService())
        vm.email = "bad-email"
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertEqual(vm.validate(), "Please enter a valid email address.")
    }

    func testValidateShortPassword() {
        let vm = RegisterViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = "12345"
        vm.confirmPassword = "12345"
        XCTAssertEqual(vm.validate(), "Password must be at least 6 characters.")
    }

    func testValidatePasswordsDoNotMatch() {
        let vm = RegisterViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = "password1"
        vm.confirmPassword = "password2"
        XCTAssertEqual(vm.validate(), "Passwords do not match.")
    }

    func testValidateSuccess() {
        let vm = RegisterViewModel(authService: MockAuthService())
        vm.email = "user@example.com"
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertNil(vm.validate())
    }
}
