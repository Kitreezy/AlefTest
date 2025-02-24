//
//  PersonalInfoViewController.swift
//  AlefTest
//
//  Created by Artem Rodionov on 18.02.2025.
//

import UIKit

final class PersonalInfoViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var presenter: PersonalInfoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PersonalInfoPresenterImp(view: self)
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
        presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return presenter.childCount
            
        default:
            return 1
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
            
            let child = presenter.child(at: indexPath.row)
            cell.configure(with: child)

            cell.onNameChanged = { [weak self] newName in
                self?.presenter.updateChildName(at: indexPath.row, name: newName)
            }

            cell.onAgeChanged = { [weak self] newAge in
                self?.presenter.updateChildAge(at: indexPath.row, age: newAge)
            }
            
            cell.deleteAction = { [weak self, weak tableView] in
                guard let self = self, let tableView = tableView else { return }
                  
                if let indexPath = tableView.indexPath(for: cell) {
                    self.presenter.removeChild(at: indexPath.row)
                    print("Удален \(indexPath.row) ребенок")
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
                    self.presenter.addChild()
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
        guard section == 1, presenter.childCount > 0 else { return nil }

        let footerView = SectionFooterView(
            clearAction: { [weak self] in
                self?.presenter.showClearActionSheet()
            }
        )
        return footerView
    }
    
    func reloadTable() {
        tableView.reloadSections([1], with: .automatic)
    }
    
    func deleteRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 1)

        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()

        UIView.animate(withDuration: 0.3) {
            self.tableView.layoutIfNeeded()
        }
    }
    
    func updateFooterVisibility(isHidden: Bool) {
        guard let footerView = tableView.footerView(forSection: 1) else { return }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            footerView.alpha = isHidden ? 0 : 1
            footerView.frame.origin.y = self.tableView.contentSize.height - footerView.frame.height
        }) { _ in
            footerView.isHidden = isHidden
        }
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
