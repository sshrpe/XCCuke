//
//  Navigation.swift
//  XCCukeSampleApp
//
//  Created by Stuart Sharpe on 01/10/2015.
//  Copyright © 2015 initWithStyle. All rights reserved.
//

import XCTest

class Navigation: XCQStepDefinition {
        
    func IAmOnTheRootView() {
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    func IRotateMyDeviceAntiClockwise() {
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
    }
    
    func IRotateMyDeviceClockwise() {
        XCUIDevice.sharedDevice().orientation = .LandscapeRight
    }

    func MyDeviceShouldBeInLandscapeOrientation() {
        XCTAssertTrue(UIDeviceOrientationIsLandscape(XCUIDevice().orientation))

    }

}
