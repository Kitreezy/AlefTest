//
//  SectionHeaderView.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

final class SectionHeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let addButton = UIButton(type: .system)
    
    private var addAction: (() -> Void)?
    
    init(text: String, showButton: Bool, addAction: (() -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.addAction = addAction
        
        setupTitle(title: text)
        checkButton(showButton: showButton)
        
        setupViews()
        layoutConstraints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitle(title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func checkButton(showButton: Bool) {
        if showButton {
            addButton.setTitle("+ Добавить ребенка", for: .normal)
            addButton.alpha = 0.8
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            
            addSubview(addButton)
            
            addButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                addButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
    
    @objc private func addTapped() {
        print("Кнопка в SectionHeaderView нажата") 
        addAction?()
    }
}

extension SectionHeaderView {
    
    func setupViews() {
        addSubview(titleLabel)
    }
    
    func layoutConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureAppearance() {
        
    }
}
