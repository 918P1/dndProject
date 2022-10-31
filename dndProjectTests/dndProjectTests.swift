//
//  dndProjectTests.swift
//  dndProjectTests
//
//  Created by Chad Parr on 10/28/22.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import dndProject

extension ContentView: Inspectable { }

final class dndProjectTests: XCTestCase {
    
    func testStringValue() throws {
           let sut = ContentView()
           let value = try sut.inspect().text(0).string()
           XCTAssertEqual(value, "Dungeons and Dragons")
       }
    

}
