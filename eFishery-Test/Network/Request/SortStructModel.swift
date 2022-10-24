//
//  SortStructModel.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

struct SortStructModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var tt: String = ""
    var vl: Int = 0
}
