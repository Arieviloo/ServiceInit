//
//  Person.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 09/08/23.
//

import UIKit

struct PersonList: Codable {
    var person: [Person]
}

struct Person: Codable {
    var name: String
    var lastName: String
    var phone: String
    
    enum CodingKeys:String, CodingKey {
        case name =  "nome"
        case lastName = "sobrenome"
        case phone = "telefone"
        
    }
    
}
