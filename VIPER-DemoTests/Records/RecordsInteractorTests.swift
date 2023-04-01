//
//  RecordsInteractorTests.swift
//  VIPER-DemoTests
//
//  Created by 辜敬閎 on 2023/4/1.
//

import XCTest
@testable import VIPER_Demo

final class RecordsInteractorTests: XCTestCase {

    private var sut: RecordsInteractor!
    
    ///
    /// 當沒有`訂單`紀錄時，`抽獎紀錄`為空
    ///
    func testWhenOrdersIsEmptyAndThenRecordsIsEmpty() {
        let mockOrderRepository = MockOrderRepository(orders: [])
        sut = makeSUT(orderRepository: mockOrderRepository)
        
        let completionCalled = expectation(description: "completion")
        sut.getRecords(completion: { records in
            completionCalled.fulfill()
            XCTAssertTrue(records.isEmpty)
        })
        
        wait(for: [completionCalled], timeout: 1.0)
    }
    
    ///
    /// 當`訂單`紀錄為`mockOrders`時，`抽獎紀錄`為`expectedRecords`
    ///
    func testOrdersTransformToRecords() {
        let mockCreatedDate = Date()
        let mockOrders = [
            Order(id: "1", lotteryNumber: "10", lotteryResult: true, createdData: mockCreatedDate),
            Order(id: "2", lotteryNumber: "50", lotteryResult: true, createdData: mockCreatedDate),
            Order(id: "3", lotteryNumber: "99", lotteryResult: false, createdData: mockCreatedDate),
            Order(id: "4", lotteryNumber: "77", lotteryResult: false, createdData: mockCreatedDate),
            Order(id: "5", lotteryNumber: "100", lotteryResult: true, createdData: mockCreatedDate)
        ]
        let mockOrderRepository = MockOrderRepository(orders: mockOrders)
        
        sut = makeSUT(orderRepository: mockOrderRepository)
        
        let expectedRecords = [
            Record(lotteryNumber: 10, lotteryResult: .win, createdDate: mockCreatedDate),
            Record(lotteryNumber: 50, lotteryResult: .win, createdDate: mockCreatedDate),
            Record(lotteryNumber: 99, lotteryResult: .lose, createdDate: mockCreatedDate),
            Record(lotteryNumber: 77, lotteryResult: .lose, createdDate: mockCreatedDate),
            Record(lotteryNumber: 100, lotteryResult: .win, createdDate: mockCreatedDate),
        ]
        let completionCalled = expectation(description: "completion")
        
        sut.getRecords(completion: { records in
            completionCalled.fulfill()
            XCTAssertTrue(records == expectedRecords)
        })
        
        wait(for: [completionCalled], timeout: 1.0)
    }
    
    private func makeSUT(orderRepository: OrderRepositoryType) -> RecordsInteractor {
        RecordsInteractor(orderRepository: orderRepository)
    }
    
}

private class MockOrderRepository: OrderRepositoryType {
    private let orders: [Order]
    
    init(orders: [Order]) {
        self.orders = orders
    }
    
    func fetchOrders(completion: (([Order]) -> Void)) {
        completion(orders)
    }
}
