//
//  PersonalInfoViewController.swift
//  AlefTest
//
//  Created by Artem Rodionov on 18.02.2025.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    private lazy var textField: CustomInfoTextField = {
        let textField = CustomInfoTextField()
        textField.customPlaceholder = "Имя"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutConstraints()
        configureAppearance()
    }


}

extension PersonalInfoViewController {
    
    func setupViews() {
        view.addSubview(textField)
    }
    
    func layoutConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureAppearance() {
        view.backgroundColor = .green
    }
}

