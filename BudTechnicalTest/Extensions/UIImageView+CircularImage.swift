//
//  UIImageView+CircularImage.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 19/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  
  func transformToCircle() {
    self.layer.cornerRadius = (self.frame.width / 2)
    self.layer.masksToBounds = true
  }
  
}
