//
//  LabelTextFieldV.swift
//  TestThuDelegate
//
//  Created by Admin on 27/6/25.
//

import UIKit

class LabelTextFieldV: UIView {

    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    /*
     
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        loadFromNib()
    }
    override func layoutSubviews() {
        
    }
    private func loadFromNib(){
        let nib = UINib(nibName: "LabelTextFieldV", bundle: nil)
        let nibView = nib.instantiate(withOwner: self).first as! UIView
        addSubview(nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    func config(label: String, textField: String){
        self.label.text = label
        self.textField.placeholder = textField
        self.viewTextField.layer.cornerRadius = 16
        self.viewTextField.clipsToBounds = true
        self.viewTextField.layer.borderWidth = 1
        self.viewTextField.layer.borderColor = UIColor.neutral4.cgColor
        //        self.textField.setBorder(radius: 16, color: .neutral4, width: 1)
    }
}
