//
//  CreateNoteViewSnapshotTest.swift
//  NotasTests
//
//  Created by Danilo Osorio on 3/04/25.
//

import Testing
import SnapshotTesting
import SwiftUI
@testable import Notas

struct CreateNoteViewSnapshotTest {

    
    @Test
    @MainActor
    func testCreateNoteView() {
       // DispatchQueue.main.async {
            let view = CreateNoteView(viewModel: .init())
            let hostingController = UIHostingController(rootView: view)
            hostingController.view.frame = UIScreen.main.bounds

            assertSnapshot(
                of: hostingController,
                as: .image(on: .iPhone12Pro),
                named: "CreateNoteView",
                record: false //UPDATE IMAGE REFERENCE
            )
      //  }
    }
    
    @Test
    @MainActor
    func testCreateNoteViewWithData() {
        let view = CreateNoteView(viewModel: .init(),
                                  text: "snapshot tes",
                                  title: "Este es un test"
                                  )
        let hostingController =  UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhone12Pro),
            named: "CreateNoteViewWithData",
            record: false
        )
        
    }
}
