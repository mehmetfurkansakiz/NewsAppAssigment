//
//  SettingsBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 18.03.2025.
//

final class SettingsBuilder {
    class func make(with viewModel: SettingsViewModel) -> SettingsViewController {
        let controller = SettingsViewController()
        controller.viewModel = viewModel
        return controller
    }
}
