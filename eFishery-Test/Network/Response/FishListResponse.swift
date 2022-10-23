//
//  FishListResponse.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

struct FishListResponse: Codable, Identifiable {
    var id = UUID()
    var uuid: String? = ""
    var komoditas: String? = "Lele Dumbo Jumbo"
    var areaProvinsi: String? = "ACEH"
    var areaKota: String? = "ACEH KOTA"
    var size: String? = "50"
    var price: String? = "100000"
    var tglParsed: String? = ""
    var timestamp: String? = ""

    enum CodingKeys: String, CodingKey {
        case uuid, komoditas
        case areaProvinsi = "area_provinsi"
        case areaKota = "area_kota"
        case size, price
        case tglParsed = "tgl_parsed"
        case timestamp
    }
}
