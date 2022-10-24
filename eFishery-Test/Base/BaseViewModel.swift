//
//  BaseViewModel.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

class BaseViewModel: NSObject, ObservableObject {
    @Published var isRefresh = false
    @Published var isLoading = false
    
    @Published var isError = false
    @Published var errorText: NetworkError = .badError
    
    @Published var isToast = false
    @Published var textToast = ""
    
    @Published var shmrAll: Bool = false
    
    @Published var isExit = false
    
    @Published var limid = 10
    @Published var oppset = 0
    @Published var page = 1
    
    var appStorage = AppStorageHelper()
    
    func ShowToast(_ txToast: String) {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.textToast = txToast
            BaseState.shared.isToast = true
        }
    }
    func ShowError(_ txError: NetworkError) {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.errorText = txError
            BaseState.shared.isError = true
        }
    }
    func ShowLoading() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.isLoading = true
        }
    }
    func ShowRefresh() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            self.isRefresh = true
        }
    }
    func DissLoadRefr() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.isLoading = false
            self.isRefresh = false
            self.shmrAll = false
        }
    }
    
    func HandleWrapperObject<T>(dly: delayLoading, result: Result<T, NetworkError>, completion: @escaping (T?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + dly.rawValue) {
            switch result {
            case .success(let dt):
                completion(dt)
            case .failure(let err):
                completion(nil)
                self.ShowError(err)
            }
            self.DissLoadRefr()
        }
    }
}

enum delayLoading: Double {
    case none = 0.0
    case short = 0.5
    case medium = 1.5
    case long = 2.5
}
