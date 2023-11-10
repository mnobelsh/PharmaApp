//
//  NetworkLogger.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation
import Alamofire

final class NetworkLogger: EventMonitor {
  
  static let shared: NetworkLogger = NetworkLogger()
  
  private init() {}
  
  func requestDidResume(_ request: Request) {
    #if DEBUG
//    let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
//    let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
//
//    let message = """
//    REQUEST:
//    \(request)
//    Headers: \(allHeaders)
//    Body Data: \(body)
//    """
//    print(message)
    #endif
  }
  
  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    #if DEBUG
    let message = """
    ================================================================
    \(response.debugDescription)
    ================================================================
    """
    print(message)
    #endif
  }
  
}
