//
//  RecordsInteractorType.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

protocol RecordsInteractorType {
    func getRecords(completion: ([Record]) -> Void)
}
