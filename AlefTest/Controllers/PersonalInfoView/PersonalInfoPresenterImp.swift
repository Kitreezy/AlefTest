//
//  PersonalInfoPresenterImp.swift
//  AlefTest
//
//  Created by Artem Rodionov on 23.02.2025.
//

import UIKit

final class PersonalInfoPresenterImp: PersonalInfoPresenter {
    
    private weak var view: PersonalInfoViewController?
    private var childData: [Child] = []
    
    init(view: PersonalInfoViewController) {
        self.view = view
    }
    
    func numberOfSections() -> Int {
        2
    }
    
    var childCount: Int {
        childData.count
    }
    
    func child(at index: Int) -> Child {
        childData[index]
    }
    
    func addChild() {
        guard childData.count < 5 else {
            print("Детей максимальное количество")
            return
        }
        
        let newChild = Child(id: UUID(), name: "")
        childData.append(newChild)
        view?.reloadTable()
    }
    
    func updateChildName(at index: Int, name: String) {
        guard index >= 0 && index < childData.count else { return }
        childData[index].name = name
    }

    func updateChildAge(at index: Int, age: Int?) {
        guard index >= 0 && index < childData.count else { return }
        childData[index].age = age
    }
    
    func showClearActionSheet() {
        let actionSheet = UIAlertController(
            title: "Очистить",
            message: "Вы уверены, что хотите удалить все данные?",
            preferredStyle: .actionSheet
            )

        let clearAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            self?.childData.removeAll()
            self?.view?.reloadTable()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)

        view?.present(actionSheet, animated: true)
    }
    
    func removeChild(at index: Int) {
        guard index >= 0 && index < childData.count else { return }
        childData.remove(at: index)
            
        if childData.isEmpty {
            view?.reloadTable()
        } else {
            view?.deleteRow(at: index)
        }
        
        view?.updateFooterVisibility(isHidden: childData.isEmpty)
    }
}
