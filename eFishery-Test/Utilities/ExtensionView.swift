//
//  ExtensionView.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

extension View {
    //func ShowToast(isShowing: Binding<Bool>, text: Binding<String>) -> some View {
    //CustomToast(isShowing: isShowing,
    //presenting: { self },
    //text: text)
    //}
    func ShowLoadingLottie(isShowing: Binding<Bool>) -> some View {
        CustomLoadingLottieView(isShowing: isShowing, content: { self.background(Color.N0) })
    }
    func ShowErrorSheet(isShowing: Binding<Bool>, err: Binding<NetworkError>) -> some View {
        self.overlay(
            CustomSheetShowHide(show: isShowing, viewBuilder: {
                CustomErrorSheet(isShowing: isShowing, err: err)
            })
        )
    }
}
