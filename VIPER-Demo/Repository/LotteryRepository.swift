//
//  LotteryRepository.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/31.
//

import Foundation

class LotteryRepository: LotteryRepositoryType {
    
    func fetechLotteryNumber(completion: (Int) -> Void) {
        // Mock api response
        completion(Int.random(in: 0...99))
    }
}
