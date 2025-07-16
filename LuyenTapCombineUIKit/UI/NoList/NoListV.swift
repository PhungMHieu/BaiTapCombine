//
//  NoListV.swift
//  TestThuDelegate
//
//  Created by Admin on 29/6/25.
//

import UIKit

class NoListV: UIView {

    override init(frame: CGRect) {
          super.init(frame: frame)
          loadFromNib()
      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)
          loadFromNib()
      }
      
      override func layoutSubviews() {
          
      }
      
      private func loadFromNib() {
          let nib = UINib(nibName: "NoListV", bundle: nil)
          let nibView = nib.instantiate(withOwner: self).first as! UIView
          
          addSubview(nibView)
          
          nibView.translatesAutoresizingMaskIntoConstraints = false
          nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
          nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
          nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
          nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      }
}
