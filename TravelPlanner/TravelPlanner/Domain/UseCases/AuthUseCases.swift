import Foundation

protocol LoginUseCase {
    func execute(email: String, password: String) async throws
}

protocol RegisterUseCase {
    func execute(email: String, password: String) async throws
}

struct DefaultLoginUseCase: LoginUseCase {
    let authService: AuthServicing

    func execute(email: String, password: String) async throws {
        try await authService.login(email: email, password: password)
    }
}

struct DefaultRegisterUseCase: RegisterUseCase {
    let authService: AuthServicing

    func execute(email: String, password: String) async throws {
        try await authService.register(email: email, password: password)
    }
}

