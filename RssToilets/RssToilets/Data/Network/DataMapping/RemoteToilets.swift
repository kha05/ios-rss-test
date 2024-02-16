//
//  ToiletsResponseDTO.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

// MARK: - RootToiletDTO
struct RemoteToilets: Decodable {
    let nhits: Int
    let parameters: RemoteParameters
    let records: [RemoteRecord]
}

// MARK: - Parameters
struct RemoteParameters: Decodable {
    let dataset: String
    let rows, start: Int
    let format, timezone: String
}

// MARK: - Record
struct RemoteRecord: Decodable {
    let datasetid: String
    let recordid: String
    let fields: RemoteToilet
    let geometry: RemoteGeometry
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Toilet
struct RemoteToilet: Decodable {
    let complementAdresse: RemoteComplementAdresse
    let geoShape: RemoteGeoShape
    let horaire: RemoteHoraire
    let accesPmr: RemoteAccesPmr
    let arrondissement: Int?
    let geoPoint2D: [Double]
    let source: String
    let gestionnaire: RemoteGestionnaire
    let adresse: String
    let type: RemoteFieldsType
    let urlFicheEquipement: String?
    let relaisBebe: RemoteAccesPmr?

    enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case geoShape = "geo_shape"
        case horaire
        case accesPmr = "acces_pmr"
        case arrondissement
        case geoPoint2D = "geo_point_2d"
        case source, gestionnaire, adresse, type
        case urlFicheEquipement = "url_fiche_equipement"
        case relaisBebe = "relais_bebe"
    }
}

enum RemoteAccesPmr: String, Decodable {
    case non = "Non"
    case oui = "Oui"

    var boolean: Bool {
        switch self {
        case .non: return false
        case .oui: return true
        }
    }
}

enum RemoteComplementAdresse: String, Decodable {
    case numeroDeVoieNomDeVoie = "numero_de_voie nom_de_voie"
}

// MARK: - GeoShape
struct RemoteGeoShape: Decodable {
    let coordinates: [[Double]]
    let type: RemoteGeoShapeType
}

enum RemoteGeoShapeType: String, Decodable {
    case multiPoint = "MultiPoint"
}

enum RemoteGestionnaire: String, Decodable {
    case toilettePubliqueDeLaVilleDeParis = "Toilette publique de la Ville de Paris"
}

enum RemoteHoraire: String, Decodable {
    case the24H24 = "24 h / 24"
    case the6H22H = "6 h - 22 h"
    case voirFicheÉquipement = "Voir fiche équipement"
}

enum RemoteFieldsType: String, Decodable {
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
}

// MARK: - Geometry
struct RemoteGeometry: Decodable {
    let type: RemoteGeometryType
    let coordinates: [Double]
}

enum RemoteGeometryType: String, Decodable {
    case point = "Point"
}
