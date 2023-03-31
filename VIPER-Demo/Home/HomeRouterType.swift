//
//  HomeRouterType.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/31.
//

import UIKit

protocol HomeRouterType {
    static func createModule() -> UIViewController
    func navigateToRecordsModule()
}
