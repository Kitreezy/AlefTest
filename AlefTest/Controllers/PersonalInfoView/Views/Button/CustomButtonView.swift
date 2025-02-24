//
//  CustomButtonView.swift
//  AlefTest
//
//  Created by Artem Rodionov on 21.02.2025.
//

import UIKit

enum CustomButtonType {
    case addChild
    case clear
}

final class CustomButtonView: UIButton {
 
    private var customType: CustomButtonType
    
    init(type: CustomButtonType) {
        self.customType = type
        super.init(frame: .zero)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        configureAppearance()
        
        switch customType {
            
        case .addChild:
            addChildSetup()
            configurePadding()
            
        case .clear:
            clearSetup()
            
        }
    }
    
    private func configurePadding() {
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
    }
}

extension CustomButtonView {
    
    func configureAppearance() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
    func addChildSetup() {
        setTitle(R.string.cell.header.addButton, for: .normal)
        setTitleColor(R.color.addButton, for: .normal)
//        titleLabel?.alpha = 0.5
        backgroundColor = .clear
        layer.borderColor = R.color.addButton.cgColor
        setImage(R.image.plus, for: .normal)
        tintColor = R.color.addButton
    }

    func clearSetup() {
        setTitle(R.string.cell.footer.clearButton, for: .normal)
        setTitleColor(.systemRed, for: .normal)
        backgroundColor = .clear
        layer.borderColor = R.color.clearButton.cgColor
    }
}
