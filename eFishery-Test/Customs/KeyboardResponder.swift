//
//  KeyboardResponder.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation(.easeInOut(duration: 1)) {
                currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation(.easeInOut(duration: 1)) {
            currentHeight = 0
        }
    }
}
