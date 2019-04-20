//
//  GraphicsAndStatistic.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

public func returnYearsValue(reverse: Bool) -> [Int]{
    let array = Array(1960...2016)
        if !reverse{
            return array
        }
        else{
            return array.reversed()
        }
}

