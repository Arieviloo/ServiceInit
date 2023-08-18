//
//  HomeViewModel.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 09/08/23.
//

import UIKit

protocol HomeViewModelProtocol:AnyObject {
    func success()
    func erro(message: String)
}

class HomeViewModel:NSObject {
    private var service: Service = Service()
    private var personList: [Person] = []
    private weak var delegate: (HomeViewModelProtocol)?
    
    public func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func fetchRequest() {
        service.getService { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let sucess):
                personList = sucess.person
                delegate?.success()
            case .failure(let failure):
                delegate?.erro(message: failure.localizedDescription)
            }
        }
    }
    
    public var numberOfRowsInSection: Int {
        return personList.count
    }
    
    public func loadCurrentPerson(indexPath: IndexPath) -> Person {
        return personList[indexPath.row]
    }
    
}


