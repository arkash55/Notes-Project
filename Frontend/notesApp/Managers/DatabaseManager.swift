//
//  DatabaseManager.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 12/01/2022.
//

import Foundation

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    ///function to get user notes
    public func getUserNotes(completion: @escaping GetNotesCompletion) {
        guard let user_id = UserDefaults.standard.value(forKey: "user_id") as? Int,
              let access_token = UserDefaults.standard.value(forKey: "access_token") as? String else {
                  completion(.failure(MiscError.missing_cache))
                  return
              }
        
        guard let url = ApiUrls.getNotesUrl else {
            completion(.failure(MiscError.faulty_url))
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.path += "/\(user_id)"
        guard let finalUrl = urlComponents?.url else {
            completion(.failure(MiscError.faulty_url))
            return
        }

        var request = URLRequest(url: finalUrl)
        request.httpMethod = HttpMethods.get
        request.addValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            switch response.statusCode {
            case 200:
                //decode
                do {
                    let decodedData = try JSONDecoder().decode([NotesModel].self, from: data)
                    completion(.success(decodedData))
                    return
                } catch {
                    completion(.failure(DataError.decode_failed))
                    return
                }
            case 400:
                completion(.failure(ResponseError.bad_request))
            case 401:
                TokenManager.shared.getNewAccessToken { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.getUserNotes(completion: completion)
                    case .failure(let err):
                        completion(.failure(err))
                        return
                    }
                }
        
            default:
                completion(.failure(ResponseError.unknown_code))
                return
            }
        }
        task.resume()
        
    }
    
    
    
    
    ///function to get urgent user notes
    public func getUserUrgentNotes(completion: @escaping GetNotesCompletion) {
        guard let user_id = UserDefaults.standard.value(forKey: "user_id") as? Int,
              let access_token = UserDefaults.standard.value(forKey: "access_token") as? String else {
                  completion(.failure(MiscError.missing_cache))
                  return
              }
        
        guard let url = ApiUrls.getUrgentNotesUrl else {
            completion(.failure(MiscError.faulty_url))
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.path += "/\(user_id)"
        guard let finalUrl = urlComponents?.url else {
            completion(.failure(MiscError.faulty_url))
            return
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = HttpMethods.get
        request.addValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            switch response.statusCode {
            case 200:
                //decode
                do {
                    let decodedData = try JSONDecoder().decode([NotesModel].self, from: data)
                    completion(.success(decodedData))
                    return
                } catch {
                    completion(.failure(DataError.decode_failed))
                    return
                }
            case 400:
                completion(.failure(ResponseError.bad_request))
            case 401:
                TokenManager.shared.getNewAccessToken { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.getUserNotes(completion: completion)
                    case .failure(let err):
                        completion(.failure(err))
                        return
                    }
                }
                
            default:
                completion(.failure(ResponseError.unknown_code))
                return
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    
    
    ///function to get create a new note
    public func createNote(note: NewNoteModel, completion: @escaping CreateNoteCompletion) {
        guard let url = ApiUrls.createNoteURL else {
            completion(.failure(MiscError.faulty_url))
            return
        }
        
        guard let access_token = UserDefaults.standard.value(forKey: "access_token") as? String else {
            completion(.failure(MiscError.missing_cache))
            return
        }
        
        guard let encodedData = try? JSONEncoder().encode(note) else {
            completion(.failure(DataError.encode_failed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.httpBody = encodedData
        request.addValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {print(error)}
                completion(.failure(MiscError.task_failed))
                return
            }
            
            switch response.statusCode {
            case 201:
                guard let decodedData = try? JSONDecoder().decode(NotesModel.self, from: data) else {
                    completion(.failure(DataError.decode_failed))
                    return
                }
                completion(.success(decodedData))
                return
            case 401:
                TokenManager.shared.getNewAccessToken { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.createNote(note: note, completion: completion)
                        return
                    case .failure(let error):
                        completion(.failure(error))
                        return
                    }
                }
            case 400:
                completion(.failure(ResponseError.bad_request))
            default:
                completion(.failure(ResponseError.unknown_code))
            }
            
        }
        task.resume()
        
    }
    
    
    
    
}
