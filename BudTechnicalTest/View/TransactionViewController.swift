//
//  TransactionViewController.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 17/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//


import UIKit

class TransactionViewController: UIViewController {
  
  // MARK :- Variables
  private var webService = TransactionWebService()
  
  private var transactionData = [Transaction]()
  private var transactionDataToDelete = [Transaction]()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  // MARK :- IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var deleteView: UIView!
  @IBOutlet weak var deleteViewButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBarStyling()
    setupNavigationItem()
    setupDeleteView()
    
    tableView.dataSource = self
    tableView.delegate = self
    webService.delegate = self
    
    webService.requestTransactions()
    
    tableView.allowsSelection = false
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    tableView.reloadData()
  }
  
  // MARK :- Selector Action
  @objc private func editTableView() {
    tableView.setEditing(!tableView.isEditing, animated: true)
    tableView.allowsMultipleSelectionDuringEditing = true
    tableView.isEditing ? showDeleteView() : hideDeleteView()
    navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    
    transactionDataToDelete.removeAll()
    print(transactionDataToDelete.count)
  }
  
  @objc private func deleteTableViewRows() {
    transactionData = transactionData.filter( { !transactionDataToDelete.map( { $0.id } ).contains($0.id) } )
    tableView.reloadData()
    print(transactionData.map({ $0.description }))
  }
  
  private func showDeleteView() {
    UIView.animate(withDuration: 1) {
      self.deleteView.alpha = 1
    }
  }
  
  private func hideDeleteView() {
    UIView.animate(withDuration: 1) {
      self.deleteView.alpha = 0
    }
  }
  
  // MARK :- Delete View
  private func setupDeleteView() {
    deleteView.alpha = 0
    deleteViewButton.setTitle("Remove", for: .normal)
    deleteViewButton.addTarget(self, action: #selector(deleteTableViewRows), for: .touchUpInside)
    deleteViewButton.tintColor = UIColor.white
    deleteView.backgroundColor = UIColor.red
  }
  
  
  // MARK :- Navigation Bar styling
  private func setupNavigationBarStyling() {
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    navigationController?.navigationBar.barTintColor = .black
    navigationController?.navigationBar.barStyle = .black
  }
  
  private func setupNavigationItem() {
    let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTableView))
    editButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    navigationItem.rightBarButtonItem = editButton
  }
}


// MARK :- Extensions
extension TransactionViewController: TransactionWebServiceDelegate {
  func didRecieveTransactions(transactions: Transactions) {
    self.transactionData = transactions.data
    
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
}


extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transactionData.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let transactionCell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as! TransactionTableViewCell
    let transaction = transactionData[indexPath.row]
    transactionCell.set(withTransaction: transaction)

    return transactionCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    transactionDataToDelete.append(transactionData[indexPath.row])
    print(transactionDataToDelete.count)
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    transactionDataToDelete.remove(at: indexPath.row)
    print(transactionDataToDelete.count)
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
  }
  
  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
}

