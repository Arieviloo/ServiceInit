//
//  ServiceManager.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 18/08/23.
//

import Foundation

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkLayer {
    var session: URLSession { get }
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}

class ServiceManager: NetworkLayer {
    
    static let shared: ServiceManager = ServiceManager()
    
    var session: URLSession = URLSession.shared
    
    func request<T>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        guard let url: URL = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error {
                    print("Error \(#function) -> \(error.localizedDescription)")
                    return
                }
                
                guard let data else { return }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let persons: T = try JSONDecoder().decode(T.self, from: data)
                    print("sucess -> \(persons)")
                    completion(.success(persons))
                } catch {
                    print("Error \(#function) -> \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
}
