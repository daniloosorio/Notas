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
    
    var createNoteUseCase: CreateNoteUseCase
    var fetchAllNotesUseCase: FetchAllNotesUseCase
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),
    fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        fetchAllNotes()
        
    }
    
    func createNoteWith(title: String, text:String) {
       /* let note: Note = Note(title: title, text: text, createdAt: .now) this is in memory
        notes.append(note)*/
        
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    func fetchAllNotes() {
        do{
            notes = try fetchAllNotesUseCase.FetchAllNote()
        }catch{
            print("Error \(error.localizedDescription)")
        }
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
    
    func deleteAll(){
        
    }
}
