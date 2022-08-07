//
//  CompletiionHandlers.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 14/01/2022.
//

import Foundation
import UIKit


public typealias SignInCompletion = (Result<SignInResponseModel, Error>) -> Void
public typealias DataCompletion = (Result<Data, Error>) -> Void
public typealias StringCompletion = (Result<String, Error>) -> Void
public typealias BooleanCompletion = (Result<Bool, Error>) -> Void
public typealias GetNotesCompletion = (Result<[NotesModel], Error>) -> Void
public typealias CreateNoteCompletion = (Result<NotesModel, Error>) -> Void
