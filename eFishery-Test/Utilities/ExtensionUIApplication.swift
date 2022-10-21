//
//  ExtensionUIApplication.swift
//  eFishery-Test
//
//  Created by ACI 2 on 22/10/22.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
