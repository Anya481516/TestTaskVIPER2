//
//  String+extension.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 26.11.2024.
//

import UIKit

extension String {
  func height(constraintedWidth width: CGFloat, font: UIFont, numberOfLines: Int = 0) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = numberOfLines
    label.text = self
    label.font = font
    label.sizeToFit()
    
    return label.frame.height
  }
}
