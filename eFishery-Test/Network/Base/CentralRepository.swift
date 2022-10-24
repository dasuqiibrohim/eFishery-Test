//
//  CentralRepository.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

class CentralRepository: BaseRepository {
    static let shared = CentralRepository()
    
    func ReadDataFromList(completion: @escaping (Result<[FishListResponse], NetworkError>) -> Void) {
        urlRequestr(route: CentralRoute.readDataFromList, completion: completion)
    }
    func ReadDataFromOpetionArea(completion: @escaping (Result<[OptionAreaResponse], NetworkError>) -> Void) {
        urlRequestr(route: CentralRoute.readDataFromOptionArea, completion: completion)
    }
    func ReadDataFromOptionSize(completion: @escaping (Result<[OptionSizeResponse], NetworkError>) -> Void) {
        urlRequestr(route: CentralRoute.readDataFromOptionSize, completion: completion)
    }
    func AddRowsToList(req: NewFishStructModel, completion: @escaping (Result<NewFishListResponse, NetworkError>) -> Void) {
        urlRequestr(route: CentralRoute.addRowsToList(req: req), completion: completion)
    }
}
