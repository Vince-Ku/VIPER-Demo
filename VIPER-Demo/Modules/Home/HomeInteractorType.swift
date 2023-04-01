//
//  HomeInteractorType.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/31.
//

import Foundation

protocol HomeInteractorType {
    func getLotteryResult(completion: (LotteryResult) -> Void)
}
