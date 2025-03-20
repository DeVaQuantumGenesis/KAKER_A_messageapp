//
//  Untitled.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/24.
//

import SwiftUI
import FirebaseFirestore

struct NewMessageView:View{
    @StateObject private var searchviewModel = UserSearchViewModel()
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Binding var showChat: Bool
    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30
    @State private var showDetails = false
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool
    var body: some View{
        NavigationStack{
            ScrollView{
                VStack{
                    HStack{
                        TextField("To:", text: $searchText, onCommit: {
                            focus = false
                            searchviewModel.searchUser(by: searchText)
                        })
                        .focused($focus)
                            .frame(height: 40)
                            .padding(.horizontal)
                            .background(Color(.systemGroupedBackground))
                            .autocapitalization(.none)
                        Button{
                            searchviewModel.searchUser(by: searchText)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .padding(.horizontal)
                        }
                    }
                    
                    
                    
                    if !searchText.isEmpty {
                        ForEach(searchviewModel.users) { user in
                            VStack{
                                HStack{
                                    CircularProfileImageView(user: user, size: .ChatView1)
                                    
                                    Text(user.username)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                
                            }
                            .onTapGesture{
                                Task{
                                    selectedUser = user
                                    dismiss()
                                    showChat = true
                                }
                            }
                        }
                    }
                }
            }
            .gesture(
                DragGesture().onChanged{ value in
                    
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth{
                        dismiss()
                    }
                    
                }
                
                
            )
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Find your friends")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}


class UserSearchViewModel: ObservableObject{
    @Published var users: [User] = []
    
    private let db = Firestore.firestore()
    
    func searchUser(by email: String) {
        
        db.collection("users")
        .whereField("email", isEqualTo: email)
        .getDocuments { (snapshot, error) in
            if error != nil{
                return
            }
            DispatchQueue.main.async{
                self.users = snapshot?.documents.compactMap{ document in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    }
}
