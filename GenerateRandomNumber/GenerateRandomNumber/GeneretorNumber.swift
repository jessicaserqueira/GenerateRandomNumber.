//
//  MockRandomNumber.swift
//  GenerateRandomNumberTests
//
//  Created by Jessica Serqueira on 27/07/23.
//

import Foundation

class GeneretorNumber: RandomNumberProtocol {
    static func random(in: ClosedRange<Int>) -> Int {
        return 8
    }
}
