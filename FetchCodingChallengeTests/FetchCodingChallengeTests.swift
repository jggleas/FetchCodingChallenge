//
//  FetchCodingChallengeTests.swift
//  FetchCodingChallengeTests
//
//  Created by Jacob Gleason on 10/12/23.
//

import XCTest
@testable import FetchCodingChallenge

final class FetchCodingChallengeTests: XCTestCase {
    
    func testSetCornerRadius() {
        let view = UIView()
        XCTAssertEqual(view.layer.cornerRadius, 0)
        XCTAssertEqual(view.layer.cornerCurve, .circular)
        view.setCornerRadius(to: 10)
        XCTAssertEqual(view.layer.cornerRadius, 10)
        XCTAssertEqual(view.layer.cornerCurve, .continuous)
    }
    
    func testSetBorder() {
        let view = UIView()
        XCTAssertEqual(view.layer.borderWidth, 0)
        view.setBorder(width: 12, color: .blue)
        XCTAssertEqual(view.layer.borderWidth, 12)
        XCTAssertEqual(view.layer.borderColor, UIColor.blue.cgColor)
    }
}
