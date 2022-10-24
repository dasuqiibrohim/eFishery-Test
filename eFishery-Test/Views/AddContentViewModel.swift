//
//  AddContentViewModel.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

class AddContentViewModel: BaseViewModel {
    @Published var succesAddNewFish: Bool = false
    
    
    func AddRowsToList(req: NewFishStructModel) {
        ShowLoading()
        CentralRepository.shared.AddRowsToList(req: req) { reslt in
            self.HandleWrapperObject(dly: .long, result: reslt) { dta in
                if let _ = dta {
                    self.succesAddNewFish = true
                }
            }
        }
    }
}
