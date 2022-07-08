//
//  NSMutableData+Extension.swift
//  App
//
//  Created by 김나희 on 7/8/22.
//

import Foundation

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
