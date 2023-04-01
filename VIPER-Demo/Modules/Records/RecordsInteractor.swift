//
//  RecordsInteractor.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

class RecordsInteractor: RecordsInteractorType {

    private let orderRepository: OrderRepositoryType
    
    init(orderRepository: OrderRepositoryType) {
        self.orderRepository = orderRepository
    }
    
    func getRecords(completion: ([Record]) -> Void) {
        orderRepository.fetchOrders(completion: { [weak self] orders in
            guard let self = self else { return }
            let records = self.transform(orders: orders)
            completion(records)
        })
    }
    
    private func transform(orders: [Order]) -> [Record] {
        var records: [Record] = []
        
        for order in orders {
            let record = Record(lotteryNumber: Int(order.lotteryNumber) ?? 0,
                                lotteryResult: order.lotteryResult ? .win : .lose,
                                createdDate: order.createdData)
            
            records.append(record)
        }
        
        return records
    }
    
}
