//
//  TrackingModel.swift
//  WWDC24
//
//  Created by Gustavo Sena on 09/02/24.
//

import Foundation

struct TrackingCategory: Identifiable {
    let id = UUID()
    let originalName: String
    let hintName: String
    var isSelected: Bool
}
