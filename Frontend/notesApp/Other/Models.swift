//
//  structs.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 10/01/2022.
//

import Foundation
import UIKit



struct LoginModel: Codable {
    let email: String
    let password: String
}

public struct SignInResponseModel: Codable {
    let id: Int
    let username: String
    let email: String
    let first_name: String
    let last_name: String
    let access_token: String
    let refresh_token: String
}


struct RegisterModel: Codable {
    let email: String
    let username: String
    let first_name: String
    let last_name: String
    let password: String
}

enum SettingCellType {
    case standard
    case slider
}

struct SettingCellModel {
    let title: String
    let icon: UIImage?
    let cellType: SettingCellType
    let handler: (() -> Void)?
}


struct StandardSettingCell {
    let title: String
    let icon: UIImage
    let handler: (() -> Void)

    
}

struct SliderSettingCell {
    let title: String
    let handler: (() -> Void)
}


public struct NotesModel: Codable {
    let id: Int
    let user_id: Int
    let title: String
    let body: String
    let note_type: String
    let urgency: Int
    let done_by_date: String
}


public struct NewNoteModel: Codable {
    var user_id: Int?
    var title: String?
    var body: String?
    var note_type: String?
    var urgency: Int?
    var done_by_date: String?
}


public struct NewAccessTokenModel: Codable {
    let access_token: String
}


struct SingleNoteModel {
    let title: String
    var value: String?
}
