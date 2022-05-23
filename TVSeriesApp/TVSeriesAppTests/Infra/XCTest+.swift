//
//  XCTest+.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import XCTest
@testable import TVSeriesApp

extension XCTest {
    func assertEquatable<T: Equatable>(observable: T?, equatable: Observable<T>) {
        switch observable {
        case equatable.value:
            XCTAssert(true)
        default:
            XCTFail("expected \(String(describing: equatable.value!))")
        }
    }
}
