//
//  HomeRouter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import UIKit

class HomeRouter: HomeRouterType {
    static func createModule() -> UIViewController {
        let interactor = HomeInteractor(lotteryRepository: LotteryRepository())
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let viewController = HomeViewController(presenter: presenter)
        
        return viewController
    }
    
    // Module transition
    func navigateToRecordsModule() {
        let recordsViewController = RecordsRouter.createModule()
        
        SceneDelegate.shared?.topViewController?.present(recordsViewController, animated: true)
    }
}
