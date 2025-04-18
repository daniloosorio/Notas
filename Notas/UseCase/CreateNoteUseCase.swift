//
//  CreateNoteUseCase.swift
//  Notas
//
//  Created by Danilo Osorio on 31/03/25.
//

import Foundation

protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws
}

struct CreateNoteUseCase : CreateNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol =  NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.insert(note: note)
        
    }
}
