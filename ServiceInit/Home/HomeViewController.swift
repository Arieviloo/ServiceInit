//
//  ViewController.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 09/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var screen: HomeView?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        self.screen = HomeView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRequest()
        viewModel.delegate(delegate: self)
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        DispatchQueue.main.async {
            self.screen?.configTableViewProtocols(delegate: self, dataSource: self)
            self.screen?.tableView.reloadData()
        }
    }
    
    func erro(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.setupHomeCell(data: viewModel.loadCurrentPerson(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

