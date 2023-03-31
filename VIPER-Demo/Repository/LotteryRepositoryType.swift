//
//  LotteryRepositoryType.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/31.
//

import Foundation

protocol LotteryRepositoryType {
    func fetechLotteryNumber(completion: (Int) -> Void)
}
