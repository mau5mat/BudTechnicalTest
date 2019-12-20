//
//  Transaction.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 17/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import Foundation

// MARK: - Transactions
struct Transactions: Codable {
  let data: [Transaction]
}

// MARK: - Transaction
struct Transaction: Codable {
  let id, date, description, category: String
  let currency: Currency
  let amount: Amount
  let product: Product
  
  enum CodingKeys: String, CodingKey {
    case id, date
    case description
    case category, currency, amount, product
  }
}

// MARK: - Amount
struct Amount: Codable {
  let value: Double
  let currencyISO: Currency
  
  enum CodingKeys: String, CodingKey {
    case value
    case currencyISO = "currency_iso"
  }
}

enum Currency: String, Codable {
  case gbp = "GBP"
}

// MARK: - Product
struct Product: Codable {
  let id: Int
  let title: Title
  let icon: String
}

enum Title: String, Codable {
  case lloydsBank = "Lloyds Bank"
}
