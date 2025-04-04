//
//  DeleteNote.swift
//  Notas
//
//  Created by Danilo Osorio on 1/04/25.
//

import Foundation

protocol RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws
}

struct RemoveNoteUseCase: RemoveNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol =  NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNoteWith(identifier: UUID) throws {
        try notesDatabase.remove(identifier: identifier)
    }
}
