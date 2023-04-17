//
//  HomePresenter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import Foundation

protocol HomePresenterOutputDelegate: AnyObject {
    func showLotteryResult(result: LotteryResult)
}

class HomePresenter {
    private let interactor: HomeInteractorType
    private let router: HomeRouterType

    // MARK: Output
    weak var delegate: HomePresenterOutputDelegate?
    
    init(interactor: HomeInteractorType, router: HomeRouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Input
    func recordsButtonDidTap() {
        router.navigateToRecordsModule()
    }

    func lotteryButtonDidTap() {
        interactor.getLotteryResult { [weak self] result in
            self?.delegate?.showLotteryResult(result: result)
        }
    }
}
