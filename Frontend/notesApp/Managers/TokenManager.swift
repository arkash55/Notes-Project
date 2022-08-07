//
//  TokenManager.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 05/08/2022.
//

import Foundation



class TokenManager {
    
    static let shared = TokenManager()
    
    ///function to get a new access_token
    public func getNewAccessToken(completion: @escaping BooleanCompletion) {
        guard let refresh_token = UserDefaults.standard.value(forKey: "refresh_token") as? String else {
            completion(.failure(MiscError.missing_cache))
            return
        }
        
        guard let url = ApiUrls.newAcccessTokenUrl else {
            completion(.failure(MiscError.faulty_url))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(refresh_token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            switch response.statusCode {
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(NewAccessTokenModel.self, from: data)
                    let newAccessToken = decodedData.access_token
                    UserDefaults.standard.set(newAccessToken, forKey: "access_token")
                    completion(.success(true))
                    return
                } catch {
                    completion(.failure(DataError.decode_failed))
                    return
                }
            case 403:
                completion(.failure(AuthError.refresh_token_expired))
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
