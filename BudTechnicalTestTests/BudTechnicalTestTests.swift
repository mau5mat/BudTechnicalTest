//
//  BudTechnicalTestTests.swift
//  BudTechnicalTestTests
//
//  Created by Matt Roberts on 17/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import XCTest
@testable import BudTechnicalTest

class BudTechnicalTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
  func testTransactionModel() {
    var transactionData = [Transaction]()
    
    let amount1 = Amount(value: 10.0, currencyISO: .gbp)
    let product1 = Product(id: 1, title: .lloydsBank, icon: "icon1")
    let transaction1 = Transaction(id: "1", date: "1/1/1", description: "Desc1", category: "Category1", currency: .gbp, amount: amount1, product: product1)
    
    let amount2 = Amount(value: 20.0, currencyISO: .gbp)
    let product2 = Product(id: 2, title: .lloydsBank, icon: "icon2")
    let transaction2 = Transaction(id: "2", date: "2/2/2", description: "Desc2", category: "Category2", currency: .gbp, amount: amount2, product: product2)
    
    transactionData.append(transaction1)
    transactionData.append(transaction2)
    
    let transactions = Transactions(data: transactionData)
    
    XCTAssertNotNil(transactionData)
    XCTAssertNotNil(transactions)
    
    XCTAssertEqual(amount1.value, 10.0)
    XCTAssertEqual(amount2.value, 20.0)
    
    XCTAssertEqual(product1.id, 1)
    XCTAssertEqual(product2.id, 2)
    
    XCTAssertEqual(transactions.data[0].id, "1")
    XCTAssertEqual(transactions.data[1].id, "2")
    
  }
  
  func testDecoding() throws {
    let url = URL(string: "https://www.mocky.io/v2/5b36325b340000f60cf88903")!
    let jsonData = try Data(contentsOf: url)
    
    XCTAssertNoThrow(try JSONDecoder().decode(Transactions.self, from: jsonData))
  }
  
  func testBorderExtension() {
    let imageView = UIImageView()
    imageView.addBorder(withWidth: 1, andColor: .blue)
    XCTAssertNotNil(imageView.layer.borderColor)
    XCTAssertNotNil(imageView.layer.borderWidth)
  }
  
  func testCircularImageExtension() {
    let imageView = UIImageView()
    imageView.transformToCircle()
    XCTAssertNotNil(imageView.layer.cornerRadius)
    XCTAssertEqual(imageView.layer.masksToBounds, true)
  }
  
  // Was unsure how to test the UIImageView+URL extension, 

}
