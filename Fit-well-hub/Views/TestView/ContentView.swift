//
//  ContentView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 28.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    var body: some View {
        VStack(spacing: 80) {
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode:.fill)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }.frame(width: 120, height: 120)
           
            Text(user?.login ?? "Login placeholder")
            
            Text(user?.bio ?? "Bio placeholder")
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL {
                print("invalid url")
            }catch GHError.invalidResponce {
                print("invalid responce")
            }catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func getUser() async throws -> GitHubUser {
        let endpoin = "https://api.github.com/users/vkuper77"
        
        guard let url = URL(string: endpoin) else {throw GHError.invalidURL}
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
            throw GHError.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch{
            throw GHError.invalidData
        }
        
    }
    
}

#Preview {
    ContentView()
}

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error {
    case invalidURL
    case invalidResponce
    case invalidData
}
