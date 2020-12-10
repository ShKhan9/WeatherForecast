//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by MacBook Pro on 12/7/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
  
    let vm = MainViewModel()
     
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalFile() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
          
        vm.getData(fromLocal: true) { items in
            
            XCTAssertNotNil(items ,"Invalid local json file")
            
        }
         
    }
    
    func testRemoteCall() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let exp = expectation(description: "Server fetch")
       
        vm.getData(fromLocal:false) { items in
            
            XCTAssertNotNil(items,"Invalid server response")
            
            XCTAssertTrue(items!.count > 0 , "Array must not be empty")
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { error in
            
            print(error!)
            
        }
         
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
