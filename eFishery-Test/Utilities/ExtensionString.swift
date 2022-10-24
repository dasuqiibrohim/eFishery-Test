//
//  ExtensionString.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

extension String {
    var toRupiah: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let hrg = Int(self), let formattedTipAmount = formatter.string(from: hrg as NSNumber) {
            return "Rp \(formattedTipAmount)"
        } else {
            return "Format rupiah salah."
        }
    }
    var toInt: Int {
        return Int(self) ?? 0
    }
    
}
