//
//  PersonalInfoViewController.swift
//  AlefTest
//
//  Created by Artem Rodionov on 18.02.2025.
//

import UIKit

final class PersonalInfoViewController: UIViewController {
    
    private var childData: [(name: String, age: Int)] = []
    
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
        section == 0 ? 1 : childData.count
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
            
            cell.deleteAction = { [weak self, weak tableView] in
                guard let self = self, let tableView = tableView else { return }
                        
                if let cellIndexPath = tableView.indexPath(for: cell) {
                    self.childData.remove(at: cellIndexPath.row)
                        
                    tableView.deleteRows(at: [cellIndexPath], with: .automatic)
                }
            }
            return cell
            
        default: 
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = SectionHeaderView(
                    text: R.string.cell.header.childInfo,
                    showButton: true,
                    addAction: { [weak self] in
                        guard let self = self else { return }
                        print("Детей максимальное количество")

                        if self.childData.count < 5 {
                            self.childData.append(("", 0))
                            print("Добавлено: \(self.childData.count) детей")
                            self.tableView.reloadData()
                        }
                    }
                )
                return header
            }
        return SectionHeaderView(text: R.string.cell.header.personalInfo, showButton: false)
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
        section == 1 ? 16 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        section == 1 ? UIView() : nil
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

