//
//  UserProfile.swift
//  TestThuDelegate
//
//  Created by Admin on 29/6/25.
//

import Foundation
import UIKit
struct UserProfile: Identifiable{
    let id: String = UUID().uuidString
    var firstName: String
    var lastName: String
    var fullName: String{
        return "\(firstName) \(lastName)"
    }
//    var bmi: Double
    var weight: Double{
        didSet{
            calculateBMI()
        }
    }
    var height: Double{
        didSet{
            calculateBMI()
        }
    }
    func calculateBMI()->Double{
        return Double(Int(weight / (height * height / 100_00)))
    }
    var gender: Gender
    init(firstName: String, lastName: String, weight: Double, height: Double, gender: Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.gender = gender
    }
}
enum Gender: String{
    case male
    case female
    case other
    var description: String {
        switch self {
            case .male: return "Nam"
            case .female: return "Nữ"
            case .other: return "Khác"
        }
    }
}
extension Gender {
    init(description: String) {
        switch description {
        case Gender.male.description:
            self = .male
        case Gender.female.description:
            self = .female
        default:
            self = .other
        }
    }
}
