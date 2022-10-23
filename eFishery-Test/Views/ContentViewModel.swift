//
//  ContentViewModel.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

class ContentViewModel: BaseViewModel {
    @Published var myListFish: [FishListResponse] = [FishListResponse(), FishListResponse()]
    @Published var myOptionArea: [OptionAreaResponse] = []
    @Published var myOptionSize: [OptionSizeResponse] = []
    
    @Published var shmrAll: Bool = false
    
    func GetReadDataFromList() {
        self.shmrAll = true
        CentralRepository.shared.ReadDataFromList { reslt in
            self.HandleWrapperObject(dly: .medium, result: reslt) { dt in
                self.myListFish = dt?.filter{ $0.komoditas != nil } ?? []
                self.shmrAll = false
            }
        }
    }
    func GetReadDataFromOptionArea() {
        CentralRepository.shared.ReadDataFromOpetionArea { reslt in
            self.HandleWrapperObject(dly: .short, result: reslt) { dt in
                self.myOptionArea = dt ?? []
            }
        }
    }
    func GetReadDataFromSize() {
        CentralRepository.shared.ReadDataFromOptionSize { reslt in
            self.HandleWrapperObject(dly: .short, result: reslt) { dt in
                self.myOptionSize = dt ?? []
            }
        }
    }
    
    func convertToRupiah(_ str: String) -> String {
        let harga = Int(str) ?? 0
         
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: harga as NSNumber) {
            return "Rp \(formattedTipAmount)"
        } else {
            return "Format rupiah salah."
        }
    }
}
