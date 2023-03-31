//
//  HomePresenter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import Foundation

class HomePresenter {
    private let interactor: HomeInteractorType
    private let router: HomeRouterType

    weak var viewDelegate: HomeViewControllerDelegate?
    
    init(interactor: HomeInteractorType, router: HomeRouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Input
    func topButtonDidTap() {
        router.navigateToRecordsModule()
    }

    func bottomButtonDidTap() {
        interactor.getLotteryResult { [weak self] result in
            self?.viewDelegate?.showLotteryResult(result: result)
        }
    }
}
