//
//  RecordsRouter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/31.
//

import UIKit

class RecordsRouter: RecordsRouterType {
    
    static func createModule() -> UIViewController {
        let router = RecordsRouter()
        let interactor = RecordsInteractor()
        let presenter = RecordsPresenter(router: router, interactor: interactor)
        let viewController = RecordsViewController(presenter: presenter)
        
        return viewController
    }
}
