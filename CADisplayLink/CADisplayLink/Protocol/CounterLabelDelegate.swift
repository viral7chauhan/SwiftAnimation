//
//  File.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 12/07/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import Foundation

protocol CounterLabelDelegate: AnyObject {
    func handleAnimation(percentage: Double)
}
