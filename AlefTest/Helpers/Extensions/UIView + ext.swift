//
//  UIView + ext.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let nextResponder = parentResponder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
        return nil
    }
    
}
