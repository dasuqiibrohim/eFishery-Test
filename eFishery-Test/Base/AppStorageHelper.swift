//
//  AppStorageHelper.swift
//  eFishery-Test
//
//  Created by ACI 2 on 21/10/22.
//

import SwiftUI

class AppStorageHelper {
    @AppStorage("list_fish_data") private var listFishData: Data = Data()
    func setListFishData(data: [FishListResponse]) {
        let userData = try? JSONEncoder().encode(data)
        if let dt = userData {
            self.listFishData = dt
        }
    }
    func getListFishData() -> [FishListResponse] {
        return listFishData.decodeTo([FishListResponse].self) ?? []
    }
}
