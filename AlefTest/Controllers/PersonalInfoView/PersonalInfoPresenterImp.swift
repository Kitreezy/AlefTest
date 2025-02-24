//
//  PersonalInfoPresenterImp.swift
//  AlefTest
//
//  Created by Artem Rodionov on 23.02.2025.
//

import UIKit

enum ActionSheetTitle: Int, CaseIterable {
    case mainButtonTitle
    case clearAll
    case cancel
}

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
            alertAddedMaxChild()
            return
        }
        
        let newChild = Child(id: UUID(), name: "", age: nil)
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
    
    func alertAddedMaxChild() {
        let alert = UIAlertController(
            title: R.string.AlertController.mainTitle,
            message: R.string.AlertController.messageText,
            preferredStyle: .alert
        )
        
        let actionButton = UIAlertAction(title: R.string.AlertController.buttonTitle, style: .default)
        
        alert.addAction(actionButton)
        
        view?.present(alert, animated: true)
    }
    
    func showClearActionSheet() {
        let actionSheet = UIAlertController(
            title: R.string.ActionSheet.title(for: .mainButtonTitle),
            message: R.string.ActionSheet.messageText,
            preferredStyle: .actionSheet
            )

        let clearAction = UIAlertAction(title: R.string.ActionSheet.title(for: .clearAll), style: .destructive) { [weak self] _ in
            self?.childData.removeAll()
            self?.view?.reloadTable()
        }

        let cancelAction = UIAlertAction(title: R.string.ActionSheet.title(for: .cancel), style: .cancel)

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
