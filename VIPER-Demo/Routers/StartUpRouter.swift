//
//  StartUpRouter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import UIKit

class StartUpRouter {
    
    // setup the initial module when the app launched
    static func createModule() -> UIViewController {
        HomeViewController()
    }
}
