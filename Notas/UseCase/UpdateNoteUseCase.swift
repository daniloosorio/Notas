//
//  UpdateNoteUseCase.swift
//  Notas
//
//  Created by Danilo Osorio on 1/04/25.
//

import Foundation


protocol UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String) async throws
}

struct UpdateNoteUseCase: UpdateNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    init(notesDatabase: NotesDatabaseProtocol =  NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNoteWith(identifier: UUID, title: String, text: String) async throws {
        try await notesDatabase.update(identifier: identifier, title: title, text:text)
    }
    
    
}
