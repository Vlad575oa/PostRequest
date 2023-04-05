//
//  NetworkManager.swift
//  SendPost
//
//  Created by user on 05.04.2023.
//

import Foundation


enum Link: String {

  case postRequest1 = "https://jsonplaceholder.typicode.com/posts"
  case postRequest2 = "https://my.api.mockaroo.com/one?key=d6c62520&__method=POST"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serializationError
}

  class NetworkManager {
  static let shared = NetworkManager()

  private init() {}
  func postRequestOne(with data: [String: Any], to url: String, completion: @escaping(Result<Any, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
      completion(.failure(.invalidURL))
      return
    }

    let courseData = try? JSONSerialization.data(withJSONObject: data)

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = courseData


    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, let response = response else {
        completion(.failure(.noData))
        print(error?.localizedDescription ?? "No error description")
        return
      }

      print(response)

      do {
        let course = try JSONSerialization.jsonObject(with: data)
        completion(.success(course))
      } catch {
        completion(.failure(.decodingError))
      }
    }.resume()
  }

  func postRequestTwo(with users: [String: Any], to urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
      guard let url = URL(string: urlString) else {
          completion(.failure(NetworkError.invalidURL))
          return
      }

      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      do {
          let httpBody = try JSONSerialization.data(withJSONObject: users, options: [])
          request.httpBody = httpBody
      } catch {
          completion(.failure(NetworkError.serializationError))
          return
      }

      URLSession.shared.dataTask(with: request) { data, response, error in
          if let error = error {
              completion(.failure(error))
              return
          }

          guard let data = data else {
              completion(.failure(NetworkError.noData))
              return
          }

          guard let responseString = String(data: data, encoding: .utf8) else {
              completion(.failure(NetworkError.decodingError))
              return
          }

          completion(.success(responseString))
      }.resume()
  }

}
