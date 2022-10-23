//
//  CentralRoute.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

enum CentralRoute: ApiConfig {
    case readDataFromList
    case addRowsToList
    case readDataFromOptionArea
    case readDataFromOptionSize
}

extension CentralRoute {
    var baseUrl: String {
        return "https://stein.efishery.com/v1/storages/" + Cnst.ntw.apiID
    }
    var path: String {
        switch self {
        case .readDataFromList, .addRowsToList:
            return "list"
        case .readDataFromOptionArea:
            return "option_area"
        case .readDataFromOptionSize:
            return "option_size"
        }
    }
    var parameter: [String : Any] {
        return [:]
    }
    var header: [String : String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    var method: HttpMethod {
        switch self {
        case .addRowsToList:
            return .post
        default:
            return .get
        }
    }
    var body: [String : Any] {
        switch self {
        case .addRowsToList:
            return [
                "uuid": "96F51B5F-2CD5-44D1-85EF-7987025A6A46",
                "komoditas": "Sarden",
                "area_provinsi": "JAWA TIMUR",
                "area_kota": "SITUBONDO",
                "size": "30",
                "price": "200000",
                "tgl_parsed": "2022-10-12 00:00:00.000+07:00",
                "timestamp": "1666511718578"
            ]
        default:
            return [:]
        }
    }
}
