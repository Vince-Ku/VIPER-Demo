//
//  HomePresenterTests.swift
//  VIPER-DemoTests
//
//  Created by 辜敬閎 on 2023/4/1.
//

import XCTest
@testable import VIPER_Demo

final class HomePresenterTests: XCTestCase {

    private var sut: HomePresenter!
    
    ///
    /// `Records Button` 點擊後，開啟 `Records` 模組
    ///
    func testRecordsButtonDidTapAndThenOpenRecordsModule() {
        let mockHomePresenterOutputDelegate = MockHomePresenterOutputDelegate()
        let mockHomeInteractor = MockHomeInteractor(lotteryResult: .win)
        let mockHomeRouter = MockHomeRouter()
        
        sut = makeSUT(delegate: mockHomePresenterOutputDelegate, interactor: mockHomeInteractor, router: mockHomeRouter)
        
        sut.recordsButtonDidTap()
        
        XCTAssertTrue(mockHomeRouter.calledFunctions.contains(where: { $0 == .navigateToRecordsModule }))
    }
    
    ///
    /// `Lottery Button` 點擊後，執行`抽獎動作`，抽獎結果`勝利`並顯示在畫面上。
    ///
    func testLotteryButtonDidTapAndThenShowSuccessfulResult() {
        let mockHomePresenterOutputDelegate = MockHomePresenterOutputDelegate()
        let mockHomeInteractor = MockHomeInteractor(lotteryResult: .win)
        let mockHomeRouter = MockHomeRouter()
        
        sut = makeSUT(delegate: mockHomePresenterOutputDelegate, interactor: mockHomeInteractor, router: mockHomeRouter)
        
        sut.lotteryButtonDidTap()
        
        XCTAssertTrue(mockHomePresenterOutputDelegate.calledFunctions.contains(where: { $0 == .showLotteryResult(.win) }))
    }
    
    ///
    /// `Lottery Button` 點擊後，執行`抽獎動作`，抽獎結果`失敗`並顯示在畫面上。
    ///
    func testLotteryButtonDidTapAndThenShowFailedResult() {
        let mockHomePresenterOutputDelegate = MockHomePresenterOutputDelegate()
        let mockHomeInteractor = MockHomeInteractor(lotteryResult: .lose)
        let mockHomeRouter = MockHomeRouter()
        
        sut = makeSUT(delegate: mockHomePresenterOutputDelegate, interactor: mockHomeInteractor, router: mockHomeRouter)
        
        sut.lotteryButtonDidTap()
        
        XCTAssertTrue(mockHomePresenterOutputDelegate.calledFunctions.contains(where: { $0 == .showLotteryResult(.lose) }))
    }
    
    private func makeSUT(delegate: HomePresenterOutputDelegate, interactor: HomeInteractorType, router: HomeRouterType) -> HomePresenter {
        let presenter = HomePresenter(interactor: interactor, router: router)
        presenter.delegate = delegate
        return presenter
    }
    
}

// MARK: Mock Objects
private class MockHomePresenterOutputDelegate: HomePresenterOutputDelegate {
    enum Function: Equatable {
        case showLotteryResult(LotteryResult)
    }
    
    var calledFunctions: [Function] = []
    
    func showLotteryResult(result: LotteryResult) {
        calledFunctions.append(.showLotteryResult(result))
    }
}

private class MockHomeInteractor: HomeInteractorType {
    private let lotteryResult: LotteryResult
    
    init(lotteryResult: LotteryResult) {
        self.lotteryResult = lotteryResult
    }
    
    func getLotteryResult(completion: (LotteryResult) -> Void) {
        completion(lotteryResult)
    }
}

private class MockHomeRouter: HomeRouterType {
    enum Function {
        case navigateToRecordsModule
    }
    
    var calledFunctions: [Function] = []
    
    static func createModule() -> UIViewController { return UIViewController() }
    
    func navigateToRecordsModule() {
        calledFunctions.append(.navigateToRecordsModule)
    }
}
