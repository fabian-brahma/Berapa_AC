//
//  Models.swift
//  Berapa_AC
//
//  Created by Fabian Brahma on 27/04/22.
//

import Foundation

struct NamaKota: Identifiable, Hashable {
    
    let name: String
    let deltaT: Float
    let kotaImage: String
    let id = UUID()
    
}

struct JenisRuang: Identifiable, Hashable {
    
    let name: String
    let internalHG: Float
    let ruangImage: String
    let id = UUID()
    
}



struct JenisDinding: Identifiable, Hashable {
    
    let name: String
    let dindingUValue: Float
    let dindingImage: String
    let id = UUID()
    
}

struct DindingExternal: Identifiable, Hashable {
    
    let name: String
    let jumlahDinding: Float
    let eksImage: String

    let id = UUID()
    
}
