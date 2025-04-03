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
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase(),
         remoteNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.removeNoteUseCase = remoteNoteUseCase
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
    
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) async {
        do {
            try await updateNoteUseCase.updateNoteWith(identifier: identifier, title: newTitle, text: newText ?? "empty")
            fetchAllNotes()
        }catch{
            print("Error \(error.localizedDescription)")
        }
    }
    
    func removeNoteWith( identifier :UUID){
        do {
            try removeNoteUseCase.removeNoteWith(identifier: identifier)
            fetchAllNotes()
        }catch{
           print("Error \(error.localizedDescription)")
        }
    }
    
}
