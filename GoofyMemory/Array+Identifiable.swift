//
//  Array+Identifiable.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 04/01/2021.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        return firstIndex { (element) -> Bool in
            element.id == matching.id
        }
    }
}
