//
//  PersonalInfoCellView.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

final class PersonalInfoCellView: UITableViewCell {
    
    static let identifier = R.string.cell.personalIdentifier
    
    private let secondNameTextField = CustomInfoTextField()
    private let firstNameTextField = CustomInfoTextField()
    private let surNameTextField = CustomInfoTextField()
    
    private let ageTextField = CustomInfoTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
        setupViews()
        layoutConstraints()
        configureAppearance()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    private func setupTextField() {
        secondNameTextField.customPlaceholder = R.string.cell.textField.secondName
        secondNameTextField.inputType = .text
        
        firstNameTextField.customPlaceholder = R.string.cell.textField.firstName
        secondNameTextField.inputType = .text
        
        surNameTextField.customPlaceholder = R.string.cell.textField.surName
        secondNameTextField.inputType = .text
        
        ageTextField.customPlaceholder = R.string.cell.textField.age
        ageTextField.inputType = .number
    }
}

extension PersonalInfoCellView {
    
    func setupViews() {
        contentView.addSubviews([secondNameTextField, firstNameTextField, surNameTextField, ageTextField])
    }
    
    func layoutConstraints() {
        secondNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            secondNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstNameTextField.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 8),
            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            surNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            surNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 8),
            surNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            surNameTextField.heightAnchor.constraint(equalToConstant: 50),
                    
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageTextField.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 8),
            ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            ageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureAppearance() {
        selectionStyle = .none
    }
}
