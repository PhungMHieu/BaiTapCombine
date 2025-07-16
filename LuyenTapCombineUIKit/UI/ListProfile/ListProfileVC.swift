//
//  ListProfileVC.swift
//  TestThuDelegate
//
//  Created by Admin on 29/6/25.
//

import UIKit
import Combine

class ListProfileVC: UIViewController{
    var selectedIndex: Int?
    var noListView: NoListV!
    private var users: [UserProfile] = []
    
    @IBOutlet weak var tableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(didTapAdd))
        addButton.tintColor = .primary
        navigationItem.rightBarButtonItem = addButton
        let nib = UINib(nibName: "ProfileViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:  "ProfileViewCell")
        tableView.backgroundColor = .background
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        setUpEmptyState()
        
        updateUI()
        UserManager.shared.$users
            .receive(on: RunLoop.main)
            .sink { [weak self] updatedUsers in
                self?.users = updatedUsers
                self?.updateUI()
            }
            .store(in: &cancellables)
    }
    
    func setUpEmptyState(){
        noListView = NoListV()
        noListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noListView)
        NSLayoutConstraint.activate([
            noListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noListView.topAnchor.constraint(equalTo: view.topAnchor),
            noListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func updateUI(){
        tableView.reloadData()
        noListView.isHidden = !users.isEmpty
    }
    @objc func didTapAdd(){
        print("Add button tapped")
        let informationVC = InformationVC()
        navigationController?.pushViewController(informationVC, animated: true)
    }
}
extension ListProfileVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell") as! ProfileViewCell
        cell.config(userProfile: users[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let profileVC = ProfileVC()
        profileVC.userIndex = user.id
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
//extension ListProfileVC: InformationDelegate{
//    func didAddUserProfile(_ userProfile: UserProfile) {
//        data.append(userProfile)
////        tableView.reloadData()
//        updateUI()
//    }
//}
//extension ListProfileVC: ProfileDelegate{
//    func getUpdateProfile(_ userProfile: UserProfile) {
//        guard let index = selectedIndex else { return }
//        data[index] = userProfile
//        let indexPath = IndexPath(row: index, section: 0)
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//    }
//}
//extension ListProfileVC: ProfileDeleteDelegate{
//    func deleteProfile(_ index: Int) {
//        data.remove(at: index)
//        updateUI()
////        tableView.reloadData()
//    }
//}


//    var data : [UserProfile] = [
//        UserProfile(firstName: "Nguyễn", lastName: "An",   weight: 68, height: 172, gender: .male),
//            UserProfile(firstName: "Trần",   lastName: "Bình", weight: 75, height: 180, gender: .male),
//            UserProfile(firstName: "Phạm",   lastName: "Chi",  weight: 55, height: 160, gender: .female),
//            UserProfile(firstName: "Lê",     lastName: "Dung", weight: 60, height: 165, gender: .female),
//            UserProfile(firstName: "Hoàng",  lastName: "Khánh",weight: 70, height: 170, gender: .other)
//    ]
//    var data : [UserProfile] = []
