//
//  SplashViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

final class SplashViewModel: SplashViewModelProtocol {
    weak var delegate: SplashViewModelDelegate?
    
    private func notify(_ output: SplashViewModelOutput) {
        delegate?.handleSplashViewModelOutput(output)
    }
}
