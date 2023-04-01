//
//  RecordsPresenter.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

class RecordsPresenter {
    
    private let router: RecordsRouterType
    private let interactor: RecordsInteractorType
    
    // MARK: Output
    weak var viewDelegate: RecordsViewControllerDelegate?
    
    init(router: RecordsRouterType, interactor: RecordsInteractorType) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: Input
    func viewDidLoad() {
        interactor.getRecords(completion: { [weak self] records in
            guard let self = self else { return }
            let recordsViewObjects = self.tranform(records: records)
            self.viewDelegate?.reloadRecords(records: recordsViewObjects)
        })
    }
    
    // TODO: implement this function, use Records Object instead
    private func tranform(records: [String]) -> [RecordCellViewObject] {
        var viewObjects: [RecordCellViewObject] = []
        
        for record in records {
            viewObjects.append(RecordCellViewObject(titleStyle: .highLight(record), detailColumnText: "123213213", starImageStyle: .none))
        }
        
        return viewObjects
    }
    
}
