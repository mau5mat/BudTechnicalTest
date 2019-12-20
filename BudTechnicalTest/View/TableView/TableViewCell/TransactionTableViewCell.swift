//
//  TransactionTableViewCell.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 17/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
  
  // MARK: - Variables
  private var transaction: Transaction?
  
  // MARK :- IBOutlets
  @IBOutlet weak var transactionIcon: UIImageView!
  @IBOutlet weak var transactionDescription: UILabel!
  @IBOutlet weak var transactionCategory: UILabel!
  @IBOutlet weak var transactionValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
      let cellSelectedBackgroundView = UIView()
      cellSelectedBackgroundView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
      UITableViewCell.appearance().selectedBackgroundView = cellSelectedBackgroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
  // MARK :- Cell Setup
  func set(withTransaction transaction: Transaction) {
    self.transaction = transaction
    setupCell(withTransaction: transaction)
  }
  
  // This function is probably doing too much.
  func setupCell(withTransaction transaction: Transaction) {
    transactionDescription.text = transaction.description
    transactionCategory.text = transaction.category
    
    transactionIcon.setImage(fromURL: transaction.product.icon)
    transactionIcon.transformToCircle()
    transactionIcon.addBorder(withWidth: 1.5, andColor: .lightGray)
 
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    
    let value = transaction.amount.value as NSNumber
    
    // Should be built differently if there were more currency types to handle
    if transaction.amount.currencyISO == .gbp {
      currencyFormatter.locale = Locale(identifier: "en_GB")
      transactionValue.text = currencyFormatter.string(from: value)
    } else {
      transactionValue.text = currencyFormatter.string(from: value)
    }
  }
  
    
}
