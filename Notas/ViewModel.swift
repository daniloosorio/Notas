//
//  ViewModel.swift
//  Notas
//
//  Created by Danilo Osorio on 19/03/25.
//

import Foundation
import Observation

@Observable
class ViewModel  {
    var notes : [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text:String){
        let note: Note = Note(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: { $0.identifier == identifier}) {
            let updateNote = Note(identifier:identifier,title: newTitle, text: newText ?? "empty", createdAt: notes[index].createdAt)
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith( identifier :UUID){
        notes.removeAll(where: { $0.identifier == identifier})
    }
    
}
