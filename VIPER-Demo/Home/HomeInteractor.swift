//
//  HomeInteractor.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import Foundation

class HomeInteractor {

    func getLotteryResult(completion: (LotteryResult) -> Void) {
        fetechLotteryNumber { luckyNumber in
            // if this logic become more complex, you can encapsulate to another object (e.g. LottertUseCase)
            if luckyNumber > 50 {
                completion(.win)
            } else {
                completion(.lose)
            }
        }
    }
    
    // fetching data from the data layer, such as Repository
    private func fetechLotteryNumber(completion: (Int) -> Void) {
        completion(Int.random(in: 0...99))
    }
}
