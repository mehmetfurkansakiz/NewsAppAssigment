//
//  AddNewsBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 5.04.2025.
//

final class AddNewsBuilder {
    class func make(with viewModel: AddNewsViewModel) -> AddNewsViewController {
        let controller = AddNewsViewController()
        controller.viewModel = viewModel
        return controller
    }
}
