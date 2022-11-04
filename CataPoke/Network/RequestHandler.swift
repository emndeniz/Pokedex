//
//  RequestHandler.swift
//  CataPoke
//
//  Created by Emin on 3.11.2022.
//

import Foundation


/// Application specific error enum
enum APIError: Error {
case jsonConversionFailure
case invalidData
case invalidRequest
case responseUnsuccessful(Error)
    var localizedDescription: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .invalidRequest: return "Invalid Request Type"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

class RequestHandler : RequestHandling {    
    
    private var urlSession:URLSession
    
    init(urlSession: URLSession = .shared ) {
        self.urlSession = urlSession
    }
    
    /// Starts resuest flow given service with required parameters and returns result in completion block.
    /// - Parameters:
    ///   - route: APIRoute that will be used in request
    ///   - completion: Completion with Service Result, may contain Decodable response or APIError
    func request<T>(route: APIRoute, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        
        guard let request = route.asRequest() else {
            completion(.failure(.invalidRequest))
            return
        }
        
        execute(request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    
                    let response =  try decoder.decode(T.self, from: data)
                    
                    Logger.log.debug("Successfull response received, response:", context: response)
                    completion(.success(response))
                }
                catch let error{
                    Logger.log.error("Failed to decode received data :", context: error)
                    completion(.failure(.jsonConversionFailure))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
    /// Executes given request.
    /// - Parameters:
    ///   - request: URLRequest
    ///   - deliveryQueue: DispatchQueue of the request, default is main.
    ///   - completion: Completion block.
    private func execute(_ request:URLRequest,
                         deliveryQueue:DispatchQueue = DispatchQueue.main,
                         completion: @escaping (Result<Data, APIError>) -> Void) {
        
        Logger.log.debug("App will send request, request:", context: request)
        urlSession.dataTask(with: request) { data, response , error in
            
            if let error = error {
                deliveryQueue.async{
                    Logger.log.error("Error recevied on request, error:", context: error)
                    completion(.failure(.responseUnsuccessful(error)))
                }
            }else if let data = data {
                deliveryQueue.async{
                    completion(.success(data))
                }
            }else {
                deliveryQueue.async{
                    Logger.log.error("Invalid data received, response:", context: response)
                    completion(.failure(.invalidData))
                }
            }
        }.resume()
        
    }
    
    
}
