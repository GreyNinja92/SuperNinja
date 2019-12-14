//
//  Constants.swift
//  Super Ninja
//
//  Created by Saksham Ram Khatod on 29/12/18.
//  Copyright © 2018 Saksham Khatod. All rights reserved.
//

import Foundation
import UIKit

//Configuration
let groundHeight : CGFloat = 20.0

//Initial Variable
let defaultXToMovePerSecond : CGFloat = 400.0

//Collision Detection
let heroCategory : UInt32 = 0x1 << 0
let wallCategory : UInt32 = 0x1 << 1

//Game Variables
let kNumberOfPointsPerLevel = 5
let kLevelGenerationTimes: [TimeInterval] = [1.0, 0.8, 0.6, 0.4, 0.3]
