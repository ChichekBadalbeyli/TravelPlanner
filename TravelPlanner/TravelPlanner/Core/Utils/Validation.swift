//
//  String.swift
//  TravelPlanner
//
//  Created by Chichak Badalbayli on 2/22/26.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(location: 0, length: utf16.count)
        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
}

