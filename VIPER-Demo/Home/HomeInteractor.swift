//
//  HomeInteractor.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/3/30.
//

import Foundation

class HomeInteractor: HomeInteractorType {

    private let lotteryRepository: LotteryRepositoryType
    
    init(lotteryRepository: LotteryRepositoryType) {
        self.lotteryRepository = lotteryRepository
    }
    
    func getLotteryResult(completion: (LotteryResult) -> Void) {
        lotteryRepository.fetechLotteryNumber { luckyNumber in
            //
            // Note that this logic would be put into the Backend system in the real world
            //
            // if this logic become more complex, you can encapsulate to another object (e.g. LottertUseCase)
            //
            if luckyNumber > 50 {
                completion(.win)
            } else {
                completion(.lose)
            }
        }
    }
}
