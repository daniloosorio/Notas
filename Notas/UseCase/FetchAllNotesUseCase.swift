//
//  FetchAllNotesUseCase.swift
//  Notas
//
//  Created by Danilo Osorio on 31/03/25.
//

import Foundation

protocol FetchAllNotesProtocol {
    func FetchAllNote() throws -> [Note]
}

struct FetchAllNotesUseCase : FetchAllNotesProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func FetchAllNote() throws -> [Note] {
            try notesDatabase.fetchAll()
        
    }
    
    
}
