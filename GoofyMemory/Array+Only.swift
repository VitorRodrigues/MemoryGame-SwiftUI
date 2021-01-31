//
//  Array+Only.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 31/01/2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
