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
            self.HandleWrapperObject(dly: .long, result: reslt) { dt in
                self.myListFish = dt?.filter{ $0.komoditas != nil && $0.areaProvinsi != nil && $0.areaKota != nil && $0.size != nil && $0.price != nil } ?? []
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
    
    func SortFilterListFish(typeSort: Int, rangePrice: ClosedRange<Float>) {
        shmrAll = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            myListFish = myListFish.filter({ $0.price!.toInt >= Int(rangePrice.lowerBound) && $0.price!.toInt <= Int(rangePrice.upperBound) })
            
            switch typeSort {
            case 1:
                myListFish = myListFish.sorted(by: { $0.price!.toInt < $1.price!.toInt })
            case 2:
                myListFish = myListFish.sorted(by: { $0.price!.toInt > $1.price!.toInt })
            case 3:
                myListFish = myListFish.sorted(by: { $0.size!.toInt < $1.size!.toInt })
            case 4:
                myListFish = myListFish.sorted(by: { $0.size!.toInt > $1.size!.toInt })
            default:
                break
            }
            shmrAll = false
        }
    }
}
