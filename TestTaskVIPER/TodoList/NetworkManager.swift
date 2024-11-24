//
//  NetworkManager.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

struct Todos: Codable, Hashable {
  struct Todo: Codable, Hashable {
    let id: Int
    let todo: String
    let isCompleted: Bool
    let userId: Int

    enum CodingKeys: String, CodingKey {
      case id
      case todo
      case isCompleted = "completed"
      case userId
    }
  }

  let todos: [Todo]
}

class NetwokManager {
  
  private let session: URLSession
  
  lazy var jsonDecoder: JSONDecoder = {
    JSONDecoder()
  }()
  
  init(with configuration: URLSessionConfiguration) {
    session = URLSession(configuration: configuration)
  }
  
  func obtainTasks() async throws -> Todos? {
    guard let url = URL(string: "https://dummyjson.com/todos") else { return nil }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let responseData = try await session.data(for: urlRequest)
    
    return try jsonDecoder.decode(Todos.self, from: responseData.0)
  }
}
