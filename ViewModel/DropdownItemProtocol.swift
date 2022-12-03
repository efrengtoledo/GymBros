//
//  DropdownItemProtocol.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import Foundation

protocol DropdownItemProtocol {
    var options: [DropdownOptions] {get}
    var headerTitle: String {get}
    var dropdownTitle: String {get}
    var isSelected: Bool {get set}
    
}

protocol DropdownOptionsProtocol {
    var toDropdownOptions: DropdownOptions {get}
}

struct DropdownOptions {
    enum DropdownOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropdownOptionType
    let formatted: String
    var isSelected: Bool
}


