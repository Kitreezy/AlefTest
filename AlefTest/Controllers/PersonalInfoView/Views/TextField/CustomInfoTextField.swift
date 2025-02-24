//
//  CustomInfoTextField.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

enum InputType {
    case text
    case number
}

final class CustomInfoTextField: UITextField, UITextFieldDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let textPadding = UIEdgeInsets(top: 20, left: 15, bottom: 5, right: 15)
    
    var inputType: InputType = .text
    
    var customPlaceholder: String? {
        didSet {
            titleLabel.text = customPlaceholder
            placeholder = ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        layoutConstraints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupViews()
        layoutConstraints()
        configureAppearance()
    }
        
    private func setup() {
        font = .systemFont(ofSize: 15, weight: .regular)
        addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    @objc
    private func textChanged() {
        guard let text = self.text else { return }
        
        switch inputType {
        case .text:
            self.text = text.filter { $0.isLetter || $0.isWhitespace }
        case .number:
            self.text = text.filter { $0.isNumber }
        }
    }
}


extension CustomInfoTextField {
    
    func setupViews() {
        addSubview(titleLabel)
    }
    
    func layoutConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
    
    }
    
    func configureAppearance() {
        borderStyle = .roundedRect
        delegate = self
    }
}
