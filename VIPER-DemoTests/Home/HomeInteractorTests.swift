//
//  HomeInteractorTests.swift
//  VIPER-DemoTests
//
//  Created by 辜敬閎 on 2023/4/1.
//

import XCTest
@testable import VIPER_Demo

final class HomeInteractorTests: XCTestCase {

    private var sut: HomeInteractor!
    
    ///
    /// 執行抽獎動作，獲得`抽獎號碼 10`，回傳`抽獎失敗`
    ///
    func testLotteryNumber10AndThenLose() {
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 10)
        sut = makeSUT(lotteryRepository: mockLotteryRepository)
        
        let completionCalled = expectation(description: "completion")
        sut.getLotteryResult(completion: { result in
            completionCalled.fulfill()
            XCTAssertTrue(result == .lose)
        })
        
        wait(for: [completionCalled], timeout: 1.0)
    }
    
    ///
    /// 執行抽獎動作，獲得`抽獎號碼 50`，回傳`抽獎失敗`
    ///
    func testLotteryNumber50AndThenLose() {
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 50)
        sut = makeSUT(lotteryRepository: mockLotteryRepository)
        
        let completionCalled = expectation(description: "completion")
        sut.getLotteryResult(completion: { result in
            completionCalled.fulfill()
            XCTAssertTrue(result == .lose)
        })
        
        wait(for: [completionCalled], timeout: 1.0)
    }
    
    ///
    /// 執行抽獎動作，獲得`抽獎號碼 99`，回傳`抽獎成功`
    ///
    func testLotteryNumber99AndThenWin() {
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 99)
        sut = makeSUT(lotteryRepository: mockLotteryRepository)
        
        let completionCalled = expectation(description: "completion")
        sut.getLotteryResult(completion: { result in
            completionCalled.fulfill()
            XCTAssertTrue(result == .win)
        })
        
        wait(for: [completionCalled], timeout: 1.0)
    }
    
    private func makeSUT(lotteryRepository: LotteryRepositoryType) -> HomeInteractor {
        HomeInteractor(lotteryRepository: lotteryRepository)
    }
    
}

private class MockLotteryRepository: LotteryRepositoryType {
    private let lotteryNumber: Int
    
    init(lotteryNumber: Int) {
        self.lotteryNumber = lotteryNumber
    }
    
    func fetechLotteryNumber(completion: (Int) -> Void) {
        completion(lotteryNumber)
    }
}
