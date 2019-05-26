//
//  todoAppTests.swift
//  todoAppTests
//
//  Created by Rohit Nair on 3/29/19.
//  Copyright © 2019 Rohit Nair. All rights reserved.
//

import XCTest
@testable import todoApp

class todoAppTests: XCTestCase {
  var  tasks: Task!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each testmethod in the class.
        tasks = Task(name:"")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testaddTask(){
        let emptyString = ""
        XCTAssertEqual(emptyString, tasks.name)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
