//
//  SectionFooterView.swift
//  AlefTest
//
//  Created by Artem Rodionov on 21.02.2025.
//

import UIKit

final class SectionFooterView: UIView {

    private let clearButton = CustomButtonView(type: .clear)
    
    private var clearAction: (() -> Void)?
    
    init(clearAction: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.clearAction = clearAction
        
        
        setupViews()
        layoutConstraints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc 
    private func clearTapped() {
        print("Нажата кнопка в секции footer")
        clearAction?()
    }
}

extension SectionFooterView {
    
    private func setupViews() {
        addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        print("Целевое действие добавлено к кнопке")
        clearButton.isUserInteractionEnabled = true
    }
    
    private func layoutConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            clearButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            clearButton.widthAnchor.constraint(equalToConstant: 150),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        clearButton.layoutIfNeeded()
        print("Constraints кнопки применены")
    }
    
    private func configureAppearance() {
        
    }
}
