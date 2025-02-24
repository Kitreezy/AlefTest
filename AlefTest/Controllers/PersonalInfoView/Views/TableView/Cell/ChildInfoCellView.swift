//
//  ChildInfoCellView.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

final class ChildInfoCellView: UITableViewCell {
    
    static let identifier = R.string.cell.childIdentifier
 
    let nameTextField = CustomInfoTextField()
    let ageTextField = CustomInfoTextField()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.cell.deleteButton, for: .normal)
        button.setTitleColor(R.color.deleteButton, for: .normal)
//        button.alpha = 0.5
        
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.3
        
        
        return view
    }()
   
    var deleteAction: (() -> Void)?
   
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
        nameTextField.customPlaceholder = R.string.cell.textField.firstName
        nameTextField.inputType = .text
       
        ageTextField.customPlaceholder = R.string.cell.textField.age
        ageTextField.inputType = .number

        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        ageTextField.addTarget(self, action: #selector(ageTextFieldTapped), for: .touchUpInside)
    }
    
    func configure(with child: Child) {
        nameTextField.text = child.name
        ageTextField.text = String(child.age ?? 0)
    }
    
    @objc private func ageTextFieldTapped() {
        
    }
   
    @objc private func deleteTapped() {
        print("Aboba")
        deleteAction?()
    }
}

extension ChildInfoCellView {
    
    func setupViews() {
        contentView.addSubviews([nameTextField,ageTextField, deleteButton, separatorView])
    }
    
    func layoutConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
                    
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            ageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            deleteButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 8),
            deleteButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configureAppearance() {
        selectionStyle = .none
    }
}
