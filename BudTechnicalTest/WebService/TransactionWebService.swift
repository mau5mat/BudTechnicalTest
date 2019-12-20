//
//  TransactionWebService.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 17/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import Foundation

protocol TransactionWebServiceDelegate {
  func didRecieveTransactions(transactions: Transactions)
}

class TransactionWebService {
  
  var delegate: TransactionWebServiceDelegate?
  
  // MARK :- WebRequests
  func requestTransactions() {
    guard let url = URL(string: "https://www.mocky.io/v2/5b36325b340000f60cf88903") else { return }
    
    URLSession.shared.dataTask(with: url) { (data, error, response) in
      if let data = data {
        do {
          let transactions = try JSONDecoder().decode(Transactions.self, from: data)
          self.delegate?.didRecieveTransactions(transactions: transactions)
          
        } catch let error as NSError {
          print("NSError: \(error)")
        }
      }
    }.resume()
  }
}
