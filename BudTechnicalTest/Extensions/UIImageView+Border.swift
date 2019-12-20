//
//  UIImageView+Border.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 19/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  
  func addBorder(withWidth width: CGFloat, andColor color: UIColor) {
    self.layer.borderWidth = width
    self.layer.borderColor = color.cgColor
  }
  
}
