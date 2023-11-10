//
//  APIService.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation
import Alamofire

protocol APIService: AnyObject {
  var session: Session { get }
  func get<T: Decodable>(from url: String, parameters: [String: Any]?) async throws -> T?
  func post<T: Decodable>(to url: String, body: [String: Any]?) async throws -> T?
  func post(to url: String, body: [String: Any]?) async throws
}

final class APIServiceImpl: APIService {
  
  var session: Session = {
    let config: URLSessionConfiguration = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30
    config.timeoutIntervalForResource = 45
    return Session(
      configuration: config,
      eventMonitors: [NetworkLogger.shared]
    )
  }()
  
  func get<T: Decodable>(from url: String, parameters: [String: Any]? = nil) async throws -> T? {
    return try await withCheckedThrowingContinuation { cont in
      session
        .request(url, method: .get, parameters: parameters)
        .validate()
        .responseData { response in
          switch response.result {
          case .success(let data):
            cont.resume(returning: data.decode())
          case .failure(let error):
            cont.resume(throwing: error.mapErrorState(data: response.data))
          }
        }
    }
  }
  
  func post<T: Decodable>(to url: String, body: [String : Any]?) async throws -> T? {
    return try await withCheckedThrowingContinuation { cont in
      session
        .request(url, method: .post, parameters: body)
        .validate()
        .responseData { response in
          switch response.result {
          case .success(let data):
            cont.resume(returning: data.decode())
          case .failure(let error):
            cont.resume(throwing: error.mapErrorState(data: response.data))
          }
        }
    }
  }
  
  func post(to url: String, body: [String : Any]?) async throws {
    return try await withCheckedThrowingContinuation { cont in
      session
        .request(url, method: .post, parameters: body)
        .validate()
        .responseData { response in
          switch response.result {
          case .success: cont.resume()
          case .failure(let error): cont.resume(throwing: error.mapErrorState(data: response.data))
          }
        }
    }
  }
  
}

extension AFError {
  
  func mapErrorState(data: Data?) -> ErrorState {
    guard let code = responseCode else { return .unknown }
    switch code {
    case 500...599: return .backend(description: "Internal Server Error")
    case 401: return .unauthorized
    case 408: return .requestTimout
    default:
      if let errorResponse: ErrorResponseDTO = data?.decode() {
        return .backend(description: errorResponse.error)
      }
      return .client
    }
  }
  
}
