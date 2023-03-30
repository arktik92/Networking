import SwiftUI

public final class ApiManager {
    
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    public init() {}
    
      
    public func getData<D: Decodable>(from endpoint: String, httpMethod: Method, token: [String: String]? = nil ) async throws -> D {
        guard let url = URL(string: endpoint) else {
            throw ApiError.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        // A tester
        if let token {
            urlRequest.addValue(token.values.first!, forHTTPHeaderField: token.keys.first!)
        }

        let (data, response) = try await session.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw ApiError.badStatus
        }
      
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(D.self, from: data)

        return decoded
    }
    
    
    
    
    /*
    func downloadData<T: Codable>(from endpoint: String, httpMethod: Method, token: [String: String]? = nil ) async -> T? {
           do {
               guard let url = URL(string: endpoint) else { throw ApiError.badUrl }
               var urlRequest = URLRequest(url: url)
               urlRequest.httpMethod = httpMethod.rawValue
               urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
               urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
               // A tester
               if let token {
                   urlRequest.addValue(token.values.first!, forHTTPHeaderField: token.keys.first!)
               }
               let (data, response) = try await session.data(for: urlRequest)
               guard let response = response as? HTTPURLResponse else { throw ApiError.badResponse }
               guard response.statusCode >= 200 && response.statusCode < 300 else { throw ApiError.badStatus }
               guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw ApiError.failedToDecodeResponse }
               
               return decodedResponse
           } catch ApiError.badUrl {
               print("There was an error creating the URL")
           } catch ApiError.badResponse {
               print("Did not get a valid response")
           } catch ApiError.badStatus {
               print("Did not get a 2xx status code from the response")
           } catch ApiError.failedToDecodeResponse {
               print("Failed to decode response into the given type")
           } catch {
               print("An error occured downloading the data")
           }
           
           return nil
       }
     */
}

