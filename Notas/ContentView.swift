//
//  ContentView.swift
//  Notas
//
//  Created by Danilo Osorio on 19/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var viewModel: ViewModel = .init()
    @State var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes){ note in
                    NavigationLink(value: note){
                        VStack(alignment: .leading, content: {
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        })
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status, content: {
                    Button(action: {
                        showCreateNote.toggle()
                    },label: {
                        Label("Creat Nota", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                })
            }
            .navigationTitle(Text("📝Notas"))
            .navigationDestination(for: Note.self, destination: {note in
                UpdateNoteView(viewModel: viewModel, id: note.id, text: note.getText, title: note.title)})
            .fullScreenCover(isPresented: $showCreateNote, content: {CreateNoteView(viewModel: viewModel)})
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes:[
        .init(title:"holii", text: "nota 1", createdAt: .now),
        .init(title:"holii", text: "nota 1", createdAt: .now)
    ]))
}
