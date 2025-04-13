//
//  UpdateNewsBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

final class UpdateNewsBuilder {
    class func make(with viewModel: UpdateNewsViewModel) -> UpdateNewsViewController {
        let controller = UpdateNewsViewController()
        controller.viewModel = viewModel
        return controller
    }
}
