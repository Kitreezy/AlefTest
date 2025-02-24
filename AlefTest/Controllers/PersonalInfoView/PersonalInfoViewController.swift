//
//  PersonalInfoViewController.swift
//  AlefTest
//
//  Created by Artem Rodionov on 18.02.2025.
//

import UIKit

final class PersonalInfoViewController: UIViewController {
    
    private var childData: [Child] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViews()
        layoutConstraints()
        configureAppearance()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonalInfoCellView.self, forCellReuseIdentifier: PersonalInfoCellView.identifier)
        tableView.register(ChildInfoCellView.self, forCellReuseIdentifier: ChildInfoCellView.identifier)
    }

}

extension PersonalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return childData.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoCellView.identifier,
                                                     for: indexPath) as! PersonalInfoCellView
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChildInfoCellView.identifier,
                                                     for: indexPath) as! ChildInfoCellView
            
            let child = childData[indexPath.row]
            cell.configure(with: child)
            
            cell.deleteAction = { [weak self, weak tableView] in
                guard let self = self, let tableView = tableView else { return }
                  
                if let indexPath = tableView.indexPath(for: cell) {
                    self.removeChild(at: indexPath.row)
                    print("Удален \(indexPath.row)")
                }
            }
            
            return cell
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return SectionHeaderView(text: R.string.cell.header.personalInfo, showButton: false)
            
        case 1:
            let header = SectionHeaderView(
                text: R.string.cell.header.childInfo,
                showButton: true,
                addAction: { [weak self] in
                    guard let self = self else { return }
                    addChild()
                }
            )
            return header
        
        default:
            return SectionHeaderView(text: "", showButton: false)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        case 1:
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width, bottom: 0, right: 0)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 50 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 1 ? 60 : 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 1, !childData.isEmpty else { return nil }

        let footerView = SectionFooterView(
            clearAction: { [weak self] in
                self?.showActionSheet()
            }
        )
        return footerView
    }
    
    private func addChild() {
        print("Добавлен \(childData.count) детей")
        if self.childData.count < 5 {
            let newChild = Child(name: "")
            self.childData.append(newChild)
             
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: childData.count - 1, section: 1)], with: .automatic)
            tableView.endUpdates()
        } else {
            print("Детей максимальное количество")
        }
    }
    
    private func removeChild(at index: Int) {
        guard index >= 0 && index < childData.count else { return }

        childData.remove(at: index)

        if childData.isEmpty {
            tableView.reloadSections([1], with: .automatic)  // Обновляем footer
        } else {
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @objc
    private func showActionSheet() {
        guard let viewController = self.view.parentViewController else { return }

        let actionSheet = UIAlertController(
            title: "Очистить данные",
            message: "Вы уверены, что хотите удалить все записи",
            preferredStyle: .actionSheet
        )

        let clearAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { _ in
            self.childData.removeAll()
            self.tableView.reloadSections([1], with: .automatic)
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)

        viewController.present(actionSheet, animated: true)
    }
}

extension PersonalInfoViewController {
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func layoutConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureAppearance() {
        tableView.backgroundColor = .white
    }
}
