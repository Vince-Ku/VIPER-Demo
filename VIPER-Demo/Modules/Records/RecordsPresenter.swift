//
//  RecordsPresenter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

protocol RecordsPresenterOutputDelegate: AnyObject {
    func reloadRecords(records: [RecordCellViewObject])
}

class RecordsPresenter {
    
    private let router: RecordsRouterType
    private let interactor: RecordsInteractorType
    
    // MARK: Output
    weak var delegate: RecordsPresenterOutputDelegate?
    
    init(router: RecordsRouterType, interactor: RecordsInteractorType) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: Input
    func viewDidLoad() {
        interactor.getRecords(completion: { [weak self] records in
            guard let self = self else { return }
            let recordsViewObjects = self.tranform(records: records)
            self.delegate?.reloadRecords(records: recordsViewObjects)
        })
    }
    
    private func tranform(records: [Record]) -> [RecordCellViewObject] {
        var viewObjects: [RecordCellViewObject] = []
        
        for record in records {
            switch record.lotteryResult {
            case .win:
                viewObjects.append(RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                                        detailColumnText: "您抽中的號碼為 \(record.lotteryNumber)",
                                                        starImageStyle: .regular))

            case .lose:
                viewObjects.append(RecordCellViewObject(titleStyle: .regular("下次再來"),
                                                        detailColumnText: "您抽中的號碼為 \(record.lotteryNumber)",
                                                        starImageStyle: .none))
            }
        }
        
        return viewObjects
    }
    
}
