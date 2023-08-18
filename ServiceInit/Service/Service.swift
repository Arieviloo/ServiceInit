//
//  HomeService.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 09/08/23.
//
import UIKit

class Service: NSObject {
    
    func getService(completion: @escaping(Result<[Person], Error>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/cf70fee3-bed6-4415-b8d3-11bf1f90c74a"
        
        ServiceManager.shared.request(with: urlString, method: .get, decodeType: PersonList.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.person))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
