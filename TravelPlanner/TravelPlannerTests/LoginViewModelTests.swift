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
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = ""
        vm.password = "password1"
        XCTAssertEqual(vm.validate(), L10n.Validation.fillAll)
    }

    func testValidateEmptyPassword() {
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = "user@example.com"
        vm.password = ""
        XCTAssertEqual(vm.validate(), L10n.Validation.fillAll)
    }

    func testValidateInvalidEmail() {
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = "notanemail"
        vm.password = "password1"
        XCTAssertEqual(vm.validate(), L10n.Validation.invalidEmail)
    }

    func testValidateShortPassword() {
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = "user@example.com"
        vm.password = "12345"
        XCTAssertEqual(vm.validate(), L10n.Validation.passwordLength)
    }

    func testValidateSuccess() {
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = "user@example.com"
        vm.password = "password1"
        XCTAssertNil(vm.validate())
    }

    func testValidateEmailWithSpaces() {
        let vm = LoginViewModel(loginUseCase: MockLoginUseCase())
        vm.email = "  user@example.com  "
        vm.password = "password1"
        XCTAssertNil(vm.validate())
    }
}

private struct MockLoginUseCase: LoginUseCase {
    func execute(email: String, password: String) async throws {}
}
