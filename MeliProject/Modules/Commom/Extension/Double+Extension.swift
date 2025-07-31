//
//  String+Extension.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import Foundation

extension Double {
    /// - Returns: A string formatada com 2 casas decimais (arrendondando para cima).
    func toRoundedUpString() -> String {
        let roundedValue = ceil(self * 100.0) / 100.0
        return String(format: "R$ %.2f", roundedValue)
    }
}
