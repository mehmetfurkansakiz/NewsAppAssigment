//
//  ContentListBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

final class ContentListBuilder {
    class func make(with viewModel: ContentListViewModel) -> ContentListViewController {
        let controller = ContentListViewController()
        controller.viewModel = viewModel
        return controller
    }
}
