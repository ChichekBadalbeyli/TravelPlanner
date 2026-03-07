//
//  AuthErrorMapper.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/21/26.
//

import Foundation

enum AuthErrorMapper {

    static func userFriendlyMessage(for error: Error) -> String {
        let nsError = error as NSError

      if let authError = error as? AuthServiceError {
          switch authError {
          case .firebaseNotConfigured:
              return L10n.Validation.firebaseNotConfigured
          }
      }

        let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError ?? nsError

        let name = underlying.userInfo["FIRAuthErrorNameKey"] as? String
        if name == "ERROR_INVALID_EMAIL" {
            return L10n.Validation.invalidEmail
        }
        if underlying.domain == "FIRAuthErrorDomain", underlying.code == 17008 {
            return L10n.Validation.invalidEmail
        }

        if name == "ERROR_EMAIL_ALREADY_IN_USE" {
            return L10n.Validation.emailAlreadyInUse
        }
        if name == "ERROR_WEAK_PASSWORD" {
            return L10n.Validation.passwordLength
        }
        if underlying.domain == "FIRAuthErrorDomain" {
            switch underlying.code {
            case 17007:
                return L10n.Validation.emailAlreadyInUse
            case 17026:
                return L10n.Validation.passwordLength
            case 17005:
                return L10n.Validation.accountDisabled
            case 17010:
                return L10n.Validation.tooManyAttempts
            default:
                break
            }
        }
        return L10n.Validation.invalidCredentials
    }
}
