//
//  CustomAlerVC.swift
//  TestThuDelegate
//
//  Created by iKame Elite Fresher 2025 on 1/7/25.
//

import UIKit

class CustomAlerVC: UIViewController {

    @IBOutlet weak var customPopUPV: CustomPopUP!
    override func viewDidLoad() {
        super.viewDidLoad()
        customPopUPV.layer.cornerRadius = 20
        customPopUPV.clipsToBounds = true
        var cancelBtn = customPopUPV.cancelBtn
        var yesBtn = customPopUPV.yesBtn
        cancelBtn?.layer.cornerRadius = 12
        yesBtn?.layer.cornerRadius = 12
        cancelBtn?.layer.borderWidth = 1.5
        yesBtn?.layer.borderWidth = 1.5
        cancelBtn?.layer.borderColor = UIColor.primary.cgColor
        yesBtn?.layer.borderColor = UIColor.primary.cgColor
//        customPopUPV.c
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        cancelBtn?.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        yesBtn?.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
//        view.backgroundColor = clear(self: <#T##CGContext#>, <#T##CGRect#>)
//        view.backgroundColor = clear(self: <#T##CGContext#>, <#T##CGRect#>)
        // Do any additional setup after loading the view.
    }
    init(){
//        self.customPopUPV = customPopUPV
        super.init(nibName: "CustomAlerVC", bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func cancelTapped(){
        dismiss(animated: true)
    }
    @objc private func confirmTapped(){
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
