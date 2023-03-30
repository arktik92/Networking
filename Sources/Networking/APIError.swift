//
//  File.swift
//  
//
//  Created by Esteban SEMELLIER on 30/03/2023.
//

import Foundation



/// Define your custom errors
public enum ApiError: Error {
    case badUrl
        case invalidRequest
        case badResponse
        case badStatus
        case failedToDecodeResponse
    
}

//extension ApiError {
//
//    var description: String {
//        switch self {
//        case .badUrl:
//            return "Bad URL"
//        case .invalidRequest:
//            return "Invalid Request"
//        case .badResponse:
//            return "Invalid Response Code. the Response Code is \(statusCode) but expected \"200\""
//        case .badStatus:
//            return "Bad Status"
//        case .failedToDecodeResponse:
//            return "Failed to decode response"
//        }
//    }
//}
