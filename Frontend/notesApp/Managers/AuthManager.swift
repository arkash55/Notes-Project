//
//  AuthManager.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 12/01/2022.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    
    ///Function to register a user
    public func registerUser(email: String, username: String, first_name: String, last_name: String, password: String, completion: @escaping SignInCompletion) {
        
        guard let registrationUrl = ApiUrls.registrationUrl else {
            completion(.failure(MiscError.guardFailed))
            return
        }
        
        let model = RegisterModel(email: email, username: username, first_name: first_name, last_name: last_name, password: password)
        guard let encodedData = try? JSONEncoder().encode(model) else {
            completion(.failure(DataError.encode_failed))
            return
        }
        
        var request = URLRequest(url: registrationUrl)
        request.httpMethod = HttpMethods.post
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data = data, let response = response as? HTTPURLResponse, err == nil else {
                completion(.failure(MiscError.task_failed))
                return
            }
            
            switch response.statusCode {
            case 201:
                //succesful task
                do {
                    let decodedData = try JSONDecoder().decode(SignInResponseModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(DataError.decode_failed))
                }
            case 400:
                if let err = err {
                    completion(.failure(err))
                }
            case 422:
                completion(.failure(AuthError.account_exists))
            default:
                break
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    ///Function to login user
    public func loginUser(email: String, password: String, completion: @escaping SignInCompletion) {
        
        guard let url = ApiUrls.loginUrl else {
            completion(.failure(MiscError.guardFailed))
            return
        }
        
        let model = LoginModel(email: email, password: password)
        guard let encodedData = try? JSONEncoder().encode(model) else {
            completion(.failure(DataError.encode_failed))
            return
        }
    
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(MiscError.task_failed))
                return
            }
            switch response.statusCode {
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(SignInResponseModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(DataError.decode_failed))
                }
            case 401:
                completion(.failure(AuthError.incorrect_password))
            case 404:
                completion(.failure(AuthError.user_not_exist))
            default:
                break
            }
        }
        task.resume()
    }
    
    

    
    ///function to logout user
    public func logOut(completion: @escaping BooleanCompletion) {
        guard let refresh_token = UserDefaults.standard.value(forKey: "refresh_token") as? String else {
            completion(.failure(MiscError.missing_cache))
            return
        }
        
        guard let url = ApiUrls.logOutUrl else {
            completion(.failure(MiscError.guardFailed))
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = HttpMethods.post
        request.addValue("Bearer \(refresh_token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            switch response.statusCode {
            case 200:
                completion(.success(true))
                return
            case 400:
                completion(.failure(ResponseError.bad_request))
                return
            default:
                completion(.failure(ResponseError.unknown_code))
                return
            }
        }
        task.resume()
    }
    
    
    

    
    
    
}
