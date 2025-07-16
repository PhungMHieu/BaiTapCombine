//
//  ProfileViewCell.swift
//  TestThuDelegate
//
//  Created by Admin on 29/6/25.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var height: CellWHView!
    @IBOutlet weak var weight: CellWHView!
    @IBOutlet weak var name: UILabel!
    
    //    let containerView = UIView()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        height.title.text = "H: "
        container.layer.cornerRadius = 20
        container.layer.masksToBounds = true // bo góc phần nội dung
        
        // (Tuỳ chọn) Nếu bạn muốn đổ bóng:
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.05
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
        // ⚠️ Nếu đổ bóng, bạn phải:
        container.layer.masksToBounds = false // vì shadow bị cắt nếu true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(userProfile: UserProfile){
        self.name.text = userProfile.fullName
        self.height.value.text = String(userProfile.height)
        self.weight.value.text = String(userProfile.weight)
    }
}
