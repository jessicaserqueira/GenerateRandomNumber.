//
//  RandomNumberProtocol.swift
//  GenerateRandomNumber
//
//  Created by Jessica Serqueira on 27/07/23.
//

import Foundation

protocol RandomNumberProtocol {
   static func random(in range: ClosedRange<Int>) -> Int
}

extension Int: RandomNumberProtocol {}
