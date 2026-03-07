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
              return "Firebase is not configured. Add GoogleService-Info.plist and rebuild."
          }
      }

        let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError ?? nsError

        let name = underlying.userInfo["FIRAuthErrorNameKey"] as? String
        if name == "ERROR_INVALID_EMAIL" {
            return "Please enter a valid email address."
        }
      
        if underlying.domain == "FIRAuthErrorDomain", underlying.code == 17008 {
            return "Please enter a valid email address."
        }

        if name == "ERROR_EMAIL_ALREADY_IN_USE" {
            return "This email is already registered."
        }
        if name == "ERROR_WEAK_PASSWORD" {
            return "Password must be at least 6 characters."
        }
      
        if underlying.domain == "FIRAuthErrorDomain" {
            switch underlying.code {
            case 17007:
                return "This email is already registered."
            case 17026:
                return "Password must be at least 6 characters."
            case 17005:
                return "This account has been disabled."
            case 17010:
                return "Too many attempts. Try again later."
            default:
                break
            }
        }
        return "Invalid email or password."
    }
}
