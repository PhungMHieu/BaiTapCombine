//
//  ProfileVC.swift
//  TestThuDelegate
//
//  Created by iKame Elite Fresher 2025 on 30/6/25.
//

import UIKit
import Combine

class ProfileVC: UIViewController {

    
    var fullNameText: String = ""
    var heightText: String = ""
    var weightText: String = ""
    var bmiText: String = ""
    var genderText: String = ""
    var userProfile: UserProfile?
    var userIndex: String!
    private var user: UserProfile?{
        didSet{
            updateUI()
        }
    }
    private var cancellables = Set<AnyCancellable>()

    let didRemoveUser = PassthroughSubject<UserProfile, Never>()
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var genderRes: UILabel!
    @IBOutlet weak var heightRes: UILabel!
    @IBOutlet weak var weightRes: UILabel!
    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.bindToRemoveUserPublisher(didRemoveUser)
        editBtn.layer.cornerRadius = 16
        title = "Profile"
        bindUser()
        let removeButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(didTapRemove))
        removeButton.tintColor = .primary
        navigationItem.rightBarButtonItem = removeButton
    }
    func bindUser(){
        UserManager.shared.$users
            .receive(on: RunLoop.main)
            .map{ users in
                users.first(where: {user in
                    user.id == self.userIndex
                })
            }
            .sink { user in
                self.user = user
            }
            .store(in: &cancellables)
    }
    func config(_ userProfile: UserProfile){
        self.userProfile = userProfile
        self.fullNameText = userProfile.fullName
        self.bmiText = String(Int(userProfile.calculateBMI()))
        self.heightText = String(userProfile.height)
        self.weightText = String(userProfile.weight)
        self.genderText = userProfile.gender.rawValue
        print(userProfile.fullName)
    }
    func updateUI(){
        fullName.text = user?.fullName
        if let heightValue = user?.height{
            heightRes.text = String(heightValue)
        }
        if let weightValue = (user?.weight){
            weightRes.text = String(weightValue)
        }
        genderRes.text = (user?.gender.rawValue)
        if let bmiValue = (user?.calculateBMI()){
            bmi.text = String(bmiValue)
        }
    }
    @IBAction func updateBtn(_ sender: UIButton) {
        let informationVC = InformationVC()
        informationVC.mode = .update
        informationVC.userIndex = self.userIndex
        navigationController?.pushViewController(informationVC, animated: true)
    }
    @objc func didTapRemove(){
        let alert = UIAlertController(title: "Delete profile", message: "Are you sure, you want to delete", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {[weak self] (_) in
            if let user = self?.user{
                self?.didRemoveUser.send(user)
            }
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
//    func setUpDeleteProfile(){
//        customPopUP = CustomPopUP()
//        customPopUP.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(customPopUP)
//        NSLayoutConstraint.activate([
//            customPopUP.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            customPopUP.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            customPopUP.topAnchor.constraint(equalTo: view.topAnchor),
//            customPopUP.bottomAnchor.constraint(equalTo:
//                view.bottomAnchor)
//        ])
//    }
//    weak var profileDelegate: ProfileDelegate?
//    weak var profileDeleteDelegate: ProfileDeleteDelegate?
//    var customPopUP: CustomPopUP!
//    var customPopUP: CustomPopUP!
