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
              return Localization.Validation.firebaseNotConfigured
          }
      }

        let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError ?? nsError

        let name = underlying.userInfo["FIRAuthErrorNameKey"] as? String
        if name == "ERROR_INVALID_EMAIL" {
            return Localization.Validation.invalidEmail
        }
        if underlying.domain == "FIRAuthErrorDomain", underlying.code == 17008 {
            return Localization.Validation.invalidEmail
        }

        if name == "ERROR_EMAIL_ALREADY_IN_USE" {
            return Localization.Validation.emailAlreadyInUse
        }
        if name == "ERROR_WEAK_PASSWORD" {
            return Localization.Validation.passwordLength
        }
        if underlying.domain == "FIRAuthErrorDomain" {
            switch underlying.code {
            case 17007:
                return Localization.Validation.emailAlreadyInUse
            case 17026:
                return Localization.Validation.passwordLength
            case 17005:
                return Localization.Validation.accountDisabled
            case 17010:
                return Localization.Validation.tooManyAttempts
            default:
                break
            }
        }
        return Localization.Validation.invalidCredentials
    }
}
