//
//  UpdateNoteView.swift
//  Notas
//
//  Created by Danilo Osorio on 19/03/25.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let identifier: UUID
    @State var text: String = ""
    @State var title: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("",text: $title, prompt: Text("*Titulo"),axis: .vertical)
                    TextField("",text: $text, prompt: Text("*Texto"), axis: .vertical)
                }
            }
            Button (action: {
                viewModel.removeNoteWith(identifier: identifier)
                dismiss()
            }, label: {
                Text("Eliminar Nota")
                    .foregroundStyle(.red)
                    .underline()
            })
            
        }
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    Task {
                        await viewModel.updateNoteWith(identifier:identifier, newTitle: title, newText: text)
                    }
                    dismiss()
                } label: {
                    Text("Actualizar Nota")
                        .bold()
                }
            }
        }
        .navigationTitle(Text("✏️ Editar Nota"))
    }
}

#Preview {
    NavigationStack{
        UpdateNoteView(viewModel: .init(), identifier: .init(), text: "texto de la nota", title: "editar nota")
    }
}
