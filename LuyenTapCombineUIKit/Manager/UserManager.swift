//
//  UserManager.swift
//  TestThuDelegate
//
//  Created by iKame Elite Fresher 2025 on 15/7/25.
//

import Foundation
//import Combine
import Combine
class UserManager{
    static let shared = UserManager()
    @Published private(set) var users: [UserProfile] = []
    private var cancellabels = Set<AnyCancellable>()
    private init(){
        
    }
    func addUsers(user: UserProfile){
        users.append(user)
    }
    func updateUser(_ user: UserProfile){
        
        if let index = users.firstIndex(where: {$0.id == user.id}){
            users[index] = user
            print("user đã được thay đổi là \(user.firstName) \(user.lastName)")
        }

    }
    func bindToAddUserPublisher(_ publisher: PassthroughSubject<UserProfile, Never>){
        publisher
            .sink { [weak self] newUser in
                self?.addUsers(user: newUser)
            }
            .store(in: &cancellabels)
    }
    func bindToUpdateUserPublisher(_ publisher: PassthroughSubject<UserProfile, Never>){
        publisher
            .sink { [weak self] updateUserObject in
                self?.updateUser(updateUserObject)
            }
            .store(in: &cancellabels)
    }
    func bindToRemoveUserPublisher(_ publisher: PassthroughSubject<UserProfile, Never>){
        publisher
            .sink { [weak self] removeUserObject in
                self?.removeUser(removeUserObject)
            }
            .store(in: &cancellabels)
    }
    func removeUser(_ user: UserProfile){
        users.removeAll(where: {$0.id == user.id})
    }
}
