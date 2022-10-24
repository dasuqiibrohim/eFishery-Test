//
//  BaseView.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

class BaseState: BaseViewModel {
    static let shared = BaseState()
}

struct BaseView<Content>: View where Content: View {
    @StateObject private var baseState = BaseState.shared
    
    let content: () -> Content
    var body: some View {
        NavigationView {
            content()
        }
        .preferredColorScheme(.light)
        .navigationViewStyle(.stack)
        //.ShowToast(isShowing: $baseState.isToast, text: $baseState.textToast)
        .ShowLoadingLottie(isShowing: $baseState.isLoading)
        .ShowErrorSheet(isShowing: $baseState.isError, err: $baseState.errorText)
    }
}

func GetHeightSafeArea(tops: Bool = false) -> CGFloat? {
    let safeAreaInsts = UIApplication.shared.windows.first?.safeAreaInsets
    return tops ? safeAreaInsts?.top: safeAreaInsts?.bottom
}
