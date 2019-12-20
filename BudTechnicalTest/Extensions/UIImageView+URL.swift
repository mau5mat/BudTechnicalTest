//
//  UIImageView+URL.swift
//  BudTechnicalTest
//
//  Created by Matt Roberts on 18/12/2019.
//  Copyright © 2019 Matt Roberts. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  
  func setImage(fromURL url: String) {
    if let url = URL(string: url) {
      
      URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data, let URLImage = UIImage(data: data) else {
          print("Problem loading image from URL: \(url)")
          return
        }
        
        DispatchQueue.main.async {
          self.image = URLImage
        }
        
      }.resume()
    }
  }
  
}
