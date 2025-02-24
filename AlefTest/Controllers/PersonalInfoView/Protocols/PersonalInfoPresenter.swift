//
//  PersonalInfoPresenter.swift
//  AlefTest
//
//  Created by Artem Rodionov on 23.02.2025.
//

protocol PersonalInfoPresenter {
    var childCount: Int { get }
    func child(at index: Int) -> Child
    func addChild()
    func removeChild(at index: Int)
    func showClearActionSheet()
    func numberOfSections() -> Int
    func updateChildName(at index: Int, name: String)
    func updateChildAge(at index: Int, age: Int?)
}
