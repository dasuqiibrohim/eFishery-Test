//
//  CentralRoute.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

enum CentralRoute: ApiConfig {
    case readDataFromList
    case addRowsToList(req: NewFishStructModel)
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
    var body: [[String : Any]] {
        switch self {
        case .addRowsToList(let req):
            return [
                ["uuid": uuid,
                "komoditas": req.komoditas,
                "area_provinsi": req.provinsi.uppercased(),
                "area_kota": req.kota.uppercased(),
                "size": req.size,
                "price": req.price,
                "tgl_parsed": transmissionDate,
                "timestamp": timestamp]
            ]
        default:
            return []
        }
    }
}
