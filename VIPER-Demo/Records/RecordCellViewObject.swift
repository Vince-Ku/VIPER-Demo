//
//  RecordCellViewObject.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

struct RecordCellViewObject {
    enum TitleStyle {
        case regular(String)
        case highLight(String)
    }
    
    enum StarImageStyle {
        case regular
        case none
    }
    
    let titleStyle: TitleStyle
    let detailColumnText: String
    let starImageStyle: StarImageStyle
}
