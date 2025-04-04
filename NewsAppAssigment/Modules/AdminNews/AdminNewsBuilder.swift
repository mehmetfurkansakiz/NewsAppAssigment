//
//  AdminNewsBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 3.04.2025.
//

final class AdminNewsBuilder {
    class func make(with viewModel: AdminNewsViewModel) -> AdminNewsViewController {
        let controller = AdminNewsViewController()
        controller.viewModel = viewModel
        return controller
    }
}
