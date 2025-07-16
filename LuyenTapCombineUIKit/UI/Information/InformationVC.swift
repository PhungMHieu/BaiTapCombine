//
//  InformationVC.swift
//  TestThuDelegate
//
//  Created by Admin on 27/6/25.
//
import UIKit
import Combine

protocol InformationDelegate: AnyObject{
    func didAddUserProfile(_ userProfile: UserProfile)
}
protocol InformationUpdateDelegate: AnyObject{
    func didUpdateUser(_ user: UserProfile)
}
class InformationVC: UIViewController {
    
    let didAddUser = PassthroughSubject<UserProfile, Never>()
    let didUpdateUser = PassthroughSubject<UserProfile, Never>()
    private var cancellable = Set<AnyCancellable>()
    var mode: FormMode = .add
    var userProfile: UserProfile?{
        didSet{
            if(mode == .update){
                updateUI()
            }
        }
    }
    var userIndex: String?
    
    @IBOutlet weak var heightV: LabelTextFieldV!
    @IBOutlet weak var weightV: LabelTextFieldV!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var lastNameV: LabelTextFieldV!
    @IBOutlet weak var firstNameV: LabelTextFieldV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Information"
        heightV.config(label: "Height", textField: "Cm")
        weightV.config(label: "Weight", textField: "Kg")
        firstNameV.config(label: "First name", textField: "Enter first name")
        lastNameV.config(label: "Last name", textField: "Enter last name")
        button.layer.cornerRadius = 16
        if(mode == .update){
            bindUser()
            UserManager.shared.bindToUpdateUserPublisher(didUpdateUser)
            button.titleLabel?.text = "Update"
            if let userProfile{
                firstNameV.textField.text = userProfile.firstName
                lastNameV.textField.text = userProfile.lastName
                heightV.textField.text = String(userProfile.height)
                weightV.textField.text = String(userProfile.weight)
                for i in 0..<gender.numberOfSegments{
                    if(gender.titleForSegment(at: i) == userProfile.gender.rawValue){
                        gender.selectedSegmentIndex = i
                        break
                    }
                }
            }
        }else{
            UserManager.shared.bindToAddUserPublisher(didAddUser)
        }
        if(mode == .add){
            validateInput()
            for textField in [firstNameV.textField, lastNameV.textField, heightV.textField, weightV.textField]{
                textField?.addTarget(self, action: #selector(textFieldChanged), for:.editingChanged)
            }
            gender.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }else{
            validateInputUpdate()
            for textField in [firstNameV.textField, lastNameV.textField, heightV.textField, weightV.textField]{
                textField?.addTarget(self, action: #selector(textFieldUpdate), for:.editingChanged)
            }
            gender.addTarget(self, action: #selector(textFieldUpdate), for: .editingChanged)
        }
    }
    func bindUser(){
        UserManager.shared.$users
            .receive(on: RunLoop.main)
            .map{users in users.first(where: {user in
                user.id == self.userIndex
            })}
            .sink { user in
                self.userProfile = user
            }
            .store(in: &cancellable)
    }
    func validateInput(){
        let firstName = firstNameV.textField.text ?? ""
        let lastName = lastNameV.textField.text ?? ""
        let height = heightV.textField.text ?? ""
        let weight = weightV.textField.text ?? ""
        let genderIndex = gender.selectedSegmentIndex
        let genderTitle = gender.titleForSegment(at: genderIndex) ?? ""
        if(!firstName.isEmpty && !lastName.isEmpty && !height.isEmpty &&
           !weight.isEmpty && !genderTitle.isEmpty){
            button.backgroundColor = .primary
        }else{
            button.backgroundColor = .neutral3
        }
    }
    func updateUI(){
        firstNameV.textField.text = userProfile?.firstName
        lastNameV.textField.text = userProfile?.lastName
        if let heightValue = userProfile?.height{
            heightV.textField.text = String(heightValue)
        }
        if let weightValue = (userProfile?.weight){
            weightV.textField.text = String(weightValue)
        }
        for i in 0..<gender.numberOfSegments{
            if(gender.titleForSegment(at: i) == userProfile?.gender.rawValue){
                gender.selectedSegmentIndex = i
                break
            }
        }
    }
    func validateInputUpdate(){
        let firstName = firstNameV.textField.text ?? ""
        let lastName = lastNameV.textField.text ?? ""
        let height = heightV.textField.text ?? ""
        let weight = weightV.textField.text ?? ""
        let genderIndex = gender.selectedSegmentIndex
        let genderTitle = gender.titleForSegment(at: genderIndex) ?? ""
        if(firstName != userProfile?.firstName || lastName != userProfile?.lastName
           || height != String(userProfile?.height ?? 0)
           ||  weight != String(userProfile?.weight ?? 0)
           || genderTitle != String(userProfile?.gender.rawValue ?? "male")
        ){
            button.backgroundColor = .primary
        }else{
            button.backgroundColor = .neutral3
        }
    }
    @IBAction func btn(_ sender: Any) {
        if(mode == .add){
            let firstName = firstNameV.textField.text ?? ""
            let lastName = lastNameV.textField.text ?? ""
            let weight = weightV.textField.text ?? "0"
            let height = heightV.textField.text ?? "0"
            let genderIndexPath = gender.selectedSegmentIndex
            let genderString = gender.titleForSegment(at: genderIndexPath) ?? ""
            let selectedGender = Gender(rawValue: genderString)
            let userProfile = UserProfile(firstName: firstName, lastName: lastName, weight: Double(weight) ?? 0, height: Double(height) ?? 0, gender: selectedGender ?? .male)
            didAddUser.send(userProfile)
            navigationController?.popViewController(animated: true)
        } else
        {
            var userProfile = self.userProfile
            userProfile?.firstName = firstNameV.textField.text ?? ""
            userProfile?.lastName = lastNameV.textField.text ?? ""
            if let heightValue = heightV.textField.text,
               let weightValue = weightV.textField.text{
                userProfile?.height = Double(heightValue) ?? 0.0
                userProfile?.weight = Double(weightValue) ?? 0.0
            }
            let genderString: String = gender.titleForSegment(at: gender.selectedSegmentIndex) ?? ""
            if let selectedGender = Gender(rawValue: genderString) {
                userProfile?.gender = selectedGender
            }
            if let userProfile{
                didUpdateUser.send(userProfile)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    @objc func textFieldChanged(_ sender: Any){
        validateInput()
    }
    @objc func textFieldUpdate(_ sender: Any){
        validateInputUpdate()
    }
    
}
