//
//  NotesDatabaseProtocol.swift
//  Notas
//
//  Created by Danilo Osorio on 27/03/25.
//

import Foundation

protocol NotesDatabaseProtocol {
    func insert(note: Note) async throws
    func fetchAll() async throws -> [Note]
}
