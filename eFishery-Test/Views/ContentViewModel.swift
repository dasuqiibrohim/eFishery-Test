//
//  ContentViewModel.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI
import Combine

class ContentViewModel: BaseViewModel {
    @Published var destView: AnyView = AnyView(EmptyView())
    @Published var actv: Bool = false
    
    @Published var myListFish: [FishListResponse] = [FishListResponse(), FishListResponse()]
    @Published var sListFish: [FishListResponse]? = []
    @Published var myOptionArea: [OptionAreaResponse] = []
    @Published var myOptionSize: [OptionSizeResponse] = []
    
    
    @Published var searchText = ""
    private var searchCancellable: AnyCancellable?
    
    override init() {
        super.init()
        searchCancellable = self.$searchText.removeDuplicates()
            .debounce(for: 2.0, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.SearchListFish()
                } else {
                    self.sListFish = nil
                }
            })
    }
    deinit {
        searchCancellable?.cancel()
    }
    
    func GetReadDataFromList() {
        shmrAll = true
        CentralRepository.shared.ReadDataFromList { reslt in
            self.HandleWrapperObject(dly: .long, result: reslt) { dta in
                if let dt = dta {
                    self.myListFish = dt.filter({ $0.komoditas != nil && $0.areaProvinsi != nil && $0.areaKota != nil && $0.size != nil && $0.price != nil })
                    self.appStorage.setListFishData(data: self.myListFish)
                } else {
                    self.myListFish = self.appStorage.getListFishData()
                }
            }
        }
    }
    private func GetReadDataFromOptionArea() {
        CentralRepository.shared.ReadDataFromOpetionArea { reslt in
            self.HandleWrapperObject(dly: .short, result: reslt) { dta in
                if let dt = dta {
                    self.myOptionArea = dt.filter({ $0.province != nil && $0.city != nil })
                    self.GetReadDataFromSize()
                }
            }
        }
    }
    private func GetReadDataFromSize() {
        CentralRepository.shared.ReadDataFromOptionSize { reslt in
            self.HandleWrapperObject(dly: .none, result: reslt) { dta in
                if let dt = dta {
                    self.myOptionSize = dt
                    self.DissLoadRefr()
                    self.destView = AnyView(AddContentView(optionArea: self.myOptionArea, optionSize: self.myOptionSize))
                    self.actv = true
                }
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
    func SearchListFish() {
        DispatchQueue.global(qos: .userInteractive).async {
            let result = self.myListFish
                .lazy
                .filter { wsh in
                    return wsh.komoditas!.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.sListFish = result.compactMap({ gwr in
                        return gwr
                    })
                    UIApplication.shared.endEditing()
                }
            }
        }
    }
    func GotoAddContentView() {
        ShowLoading()
        GetReadDataFromOptionArea()
    }
}
