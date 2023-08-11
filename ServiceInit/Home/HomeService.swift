//
//  HomeService.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 09/08/23.
//
import UIKit

class HomeService: NSObject {
    
    func getService(completion: @escaping(Result<PersonList, Error>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/cf70fee3-bed6-4415-b8d3-11bf1f90c74a"
        
        
        guard let url: URL = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                print("Error \(#function) -> \(error.localizedDescription)")
                return
            }
            
            guard let data else { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            do {
                let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
                print("sucess -> \(personList)")
                completion(.success(personList))
            } catch {
                print("Error \(#function) -> \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}