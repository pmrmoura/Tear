//
//  SeedDataBase.swift
//  Tear
//
//  Created by Danilo Lira
//  Copyright © 2020 FilaMed. All rights reserved.
//

import UIKit
import CoreData

struct SeedDatabase {
    static let shared = SeedDatabase()
    static var badge: [Badge?] = []
    static var mission: [Mission?] = []
    static var progress: [Progress?] = []
    
    func seed() {
        SeedDatabase.progress = self.createProgress()
        SeedDatabase.badge = self.createBadges()
        SeedDatabase.mission = self.createMissions(badges: SeedDatabase.badge)
        
    }

    func createBadges() -> [Badge?] {
        return [
            BadgeManager.shared.create(
                explainText: "Adotar pequenas atitudes na rotina e preparar a casa ou empresa para separar corretamente o lixo é uma das melhores maneiras para ajudar na preservação do meio ambiente. A coleta seletiva evita a disseminação de doenças e contribui para que os resíduos se encaminhem para os seus devidos lugares.",
                imageName: "badge0.jpeg",
                link: "Aperte para saber mais",
                name: "Astro do descarte",
                win: false
            ),
            BadgeManager.shared.create(
                explainText: "Adotar pequenas atitudes na rotina e preparar a casa ou empresa para separar corretamente o lixo é uma das melhores maneiras para ajudar na preservação do meio ambiente. A coleta seletiva evita a disseminação de doenças e contribui para que os resíduos se encaminhem para os seus devidos lugares.",
                imageName: "badge1.jpeg",
                link: "Aperte para saber mais",
                name: "Patrono do mangue",
                win: false
            ),
        ]
    }
    
    func createMissions(badges: [Badge?]) -> [Mission?]{
        return [
            MissionManager.shared.create(
                modalText: "A coleta seletiva é uma parte muito importante no descarte correto do nosso lixo! Vamos aprender a colocar cada coisa em seu lugar?",
                modalTitle: "Lixo não é tudo igual!",
                badge: badges[0]
            ),
            MissionManager.shared.create(
                modalText: "A vida no mangue está morrendo devido ao lixo. Junte-se ao movimento PE SEM LIXO para limpá-lo.",
                modalTitle: "Mutirão",
                badge: badges[1]
            ),
        ]
    }

    func createProgress() -> [Progress?]{
        return [
            ProgressManager.shared.create(air: 0.25, water: 0.25, soil: 0.25, total: 0.05, name: "City"),
            ProgressManager.shared.create(air: 0.05, water: 0.05, soil: 0.05, total: 0.35, name: "TrashNinja")
        ]
    }
}
