//
//  HealthStat.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable {
    let id = UUID()
    let stat: Double?
    let date: Date
}

