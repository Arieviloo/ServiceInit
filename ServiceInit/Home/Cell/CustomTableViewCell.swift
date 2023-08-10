//
//  CustomTableViewCell.swift
//  ServiceInit
//
//  Created by Jadië Oliveira on 10/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomTableViewCell"
    
    lazy var screen: CustomTableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CustomTableView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupAddSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAddSubView() {
        contentView.addSubview(screen)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    public func setupHomeCell(data: Person) {
        screen.nameLabel.text = "Nome: \(data.name)"
        screen.surnameLabel.text = "Nome: \(data.lastName)"
        screen.phoneLabel.text = "Nome: \(data.phone)"
    }
}
