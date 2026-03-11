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
        let vm = RegistrationViewModel(registerUseCase: MockRegisterUseCase())
        vm.email = ""
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertEqual(vm.validate(), L10n.Validation.fillAll)
    }

    func testValidateInvalidEmail() {
        let vm = RegistrationViewModel(registerUseCase: MockRegisterUseCase())
        vm.email = "bad-email"
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertEqual(vm.validate(), L10n.Validation.invalidEmail)
    }

    func testValidateShortPassword() {
        let vm = RegistrationViewModel(registerUseCase: MockRegisterUseCase())
        vm.email = "user@example.com"
        vm.password = "12345"
        vm.confirmPassword = "12345"
        XCTAssertEqual(vm.validate(), L10n.Validation.passwordLength)
    }

    func testValidatePasswordsDoNotMatch() {
        let vm = RegistrationViewModel(registerUseCase: MockRegisterUseCase())
        vm.email = "user@example.com"
        vm.password = "password1"
        vm.confirmPassword = "password2"
        XCTAssertEqual(vm.validate(), L10n.Validation.passwordsMismatch)
    }

    func testValidateSuccess() {
        let vm = RegistrationViewModel(registerUseCase: MockRegisterUseCase())
        vm.email = "user@example.com"
        vm.password = "password1"
        vm.confirmPassword = "password1"
        XCTAssertNil(vm.validate())
    }
}

private struct MockRegisterUseCase: RegisterUseCase {
    func execute(email: String, password: String) async throws {}
}
