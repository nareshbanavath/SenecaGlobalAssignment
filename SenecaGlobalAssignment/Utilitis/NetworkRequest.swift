//
//  NetworkRequest.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import UIKit

enum NetworkError: Error {
    case domainError(_ msg : Error)
    case decodingError(_ msg : Error)
}
class NetworkRequest
{
    class func makeRequest<T : Decodable>(type : T.Type , urlRequest : URLRequest , completion : @escaping (Swift.Result<T , NetworkError>)->())
    {
     // NetworkRequest.showActivityIndicater()

      let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      //  NetworkRequest.hideActivityIndicator()
            guard let data = data, error == nil else {
                
                if let error = error as NSError? {
                print(error)
                     completion(.failure(.domainError(error)))
                }
                return
            }
           
            do {
                let modelData = try JSONDecoder().decode(T.self, from: data)
            
                completion(.success(modelData))
            } catch let err{
                completion(.failure(.decodingError(err)))
            }
    }
      session.resume()
        
    }
  
  class func makeRequestArray<T : Decodable>(type : T.Type , urlRequest : URLRequest , completion : @escaping (Swift.Result<[T] , NetworkError>)->())
  {
    let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      
          guard let data = data, error == nil else {
              
              if let error = error as NSError? {
              print(error)
                   completion(.failure(.domainError(error)))
              }
              return
          }
         
          do {
              let modelData = try JSONDecoder().decode([T].self, from: data)
          
              completion(.success(modelData))
          } catch let err{
              completion(.failure(.decodingError(err)))
          }
  }
    session.resume()
      
  }
  

}
