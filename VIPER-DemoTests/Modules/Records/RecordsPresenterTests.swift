//
//  RecordsPresenterTests.swift
//  VIPER-DemoTests
//
//  Created by 辜敬閎 on 2023/4/1.
//

import XCTest
@testable import VIPER_Demo

final class RecordsPresenterTests: XCTestCase {

    private var sut: RecordsPresenter!
    
    ///
    /// 當`畫面成功載入`時，撈取`抽獎紀錄 mockRecords`，顯示所有`抽獎紀錄 expectedRecordCellViewObject`
    ///
    func testShowLotteryRecordsWhenViewDidLoad() {
        let mockRecords = [
            Record(lotteryNumber: 99, lotteryResult: .win, createdDate: Date()),
            Record(lotteryNumber: 1, lotteryResult: .lose, createdDate: Date()),
            Record(lotteryNumber: 50, lotteryResult: .lose, createdDate: Date()),
            Record(lotteryNumber: 77, lotteryResult: .win, createdDate: Date()),
        ]
        
        let expectedRecordCellViewObject = [
            RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                 detailColumnText: "您抽中的號碼為 99",
                                 starImageStyle: .regular),
            RecordCellViewObject(titleStyle: .regular("下次再來"),
                                 detailColumnText: "您抽中的號碼為 1",
                                 starImageStyle: .none),
            RecordCellViewObject(titleStyle: .regular("下次再來"),
                                 detailColumnText: "您抽中的號碼為 50",
                                 starImageStyle: .none),
            RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                 detailColumnText: "您抽中的號碼為 77",
                                 starImageStyle: .regular)
        ]
        
        let delegate = MockRecordsPresenterOutputDelegate()
        let router = MockRecordsRouter()
        let interactor = MockRecordsInteractor(records: mockRecords)
            
        sut = makeSUT(delegate: delegate, router: router, interactor: interactor)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(delegate.calledFunctions.contains(where: { $0 == .releadRecords(expectedRecordCellViewObject)}))
    }
        
    private func makeSUT(delegate: RecordsPresenterOutputDelegate, router: RecordsRouterType, interactor: RecordsInteractorType) -> RecordsPresenter {
        let presenter = RecordsPresenter(router: router, interactor: interactor)
        presenter.delegate = delegate
        return presenter
    }
}

// MARK: Mock Objects
private class MockRecordsPresenterOutputDelegate: RecordsPresenterOutputDelegate {
    enum Function: Equatable {
        static func == (lhs: MockRecordsPresenterOutputDelegate.Function, rhs: MockRecordsPresenterOutputDelegate.Function) -> Bool {
            switch (lhs, rhs) {
            case (.releadRecords(let lViewObjects), .releadRecords(let rViewObjects)):
                return lViewObjects == rViewObjects
            }
        }

        case releadRecords([RecordCellViewObject])
    }
    
    var calledFunctions: [Function] = []
    
    func reloadRecords(records: [RecordCellViewObject]) {
        calledFunctions.append(.releadRecords(records))
    }
}

private class MockRecordsRouter: RecordsRouterType {
    static func createModule() -> UIViewController { return UIViewController() }
}

private class MockRecordsInteractor: RecordsInteractorType {
    private let records: [Record]
    
    init(records: [Record]) {
        self.records = records
    }
    
    func getRecords(completion: ([Record]) -> Void) {
        completion(records)
    }
}
