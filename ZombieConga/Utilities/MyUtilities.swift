//
//  MyUtilities.swift
//  ZombieConga
//
//  Created by Quoc Nguyen on 12/14/17.
//  Copyright © 2017 Quoc Nguyen. All rights reserved.
//

import UIKit

func shortestAngle(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
    let pi = CGFloat.pi
    let doublePi = 2.0 * pi
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: doublePi)
    if angle >= pi {
        angle -= doublePi
    }
    if angle < -pi {
        angle += doublePi
    }
    return angle
}

extension CGFloat {
    func sign() -> CGFloat {
        return self >= 0.0 ? 1.0 : -1.0
    }
}
