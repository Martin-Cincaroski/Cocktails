//
//  Color.swift
//  Cocktails
//
//  Created by Martin on 7/3/21.
//

import UIKit

class Colors {
  let colorTop = UIColor(red: 224.0/255.0, green: 33.0/255.0, blue: 110.0/255.0, alpha: 1.0)
  let colorBottom = UIColor(red: 241.0/255.0, green: 72.0/255.0, blue: 77.0/255.0, alpha: 1.0)

  let gl: CAGradientLayer

  init() {
    gl = CAGradientLayer()
    gl.colors = [ colorTop, colorBottom]
    gl.locations = [ 0.0, 1.0]
  }
}
