//
//  NotesDatabaseProtocol.swift
//  Notas
//
//  Created by Danilo Osorio on 27/03/25.
//

import Foundation

protocol NotesDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func update(identifier: UUID, title:String, text:String?) async throws
    func remove(identifier:UUID) throws 
}
