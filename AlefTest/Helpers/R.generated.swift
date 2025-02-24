//
//  R.generated.swift
//  AlefTest
//
//  Created by Artem Rodionov on 20.02.2025.
//

import UIKit

enum R {
    enum string {
        enum cell {
            static var childIdentifier = "ChildInfoCellView"
            static var personalIdentifier = "PersonalInfoCellView"
            static var deleteButton = "Удалить"
            
            enum header {
                static var personalInfo = "Персональные данные"
                static var childInfo = "Дети (макс.5)"
                static var addButton = "Добавить ребенка"
            }
            enum footer{
                static var clearButton = "Очистить"
            }
            
            enum textField {
                static var secondName = "Фамилия"
                static var firstName = "Имя"
                static var surName = "Отчество"
                static var age = "Возраст"
            }
        }
    }
    
    enum image {
        static var plus = UIImage(systemName: "plus")
    }
    
    enum color {
        static var addButton = UIColor(hexString: "55AAFF")
        static var deleteButton = UIColor(hexString: "55AAFF")
        static var clearButton = UIColor(hexString: "FF2400")
    }
}
