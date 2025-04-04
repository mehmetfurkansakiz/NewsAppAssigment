//
//  AdminNewsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 3.04.2025.
//

final class AdminNewsViewModel: AdminNewsViewModelProtocol {
    weak var delegate: AdminNewsViewModelDelegate?
    
    private func notify(_ output: AdminNewsViewModelOutput) {
        delegate?.handleAdminNewsViewModelOutput(output)
    }
}
