//
//  CreateNoteView.swift
//  Notas
//
//  Created by Danilo Osorio on 19/03/25.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    @State var text: String = ""
    @State var title: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("",text: $title, prompt: Text("*Titulo"),axis: .vertical)
                    TextField("",text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* El titulo es obligatorio")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }
                ToolbarItem {
                    Button {
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("crear Nota")
                            .bold()
                    }
                }
            }
            .navigationTitle(Text("Crear Nota"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
