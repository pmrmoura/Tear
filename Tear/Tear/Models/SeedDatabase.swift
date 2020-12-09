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
    static var city: [City?] = []
    
    func seed() {
        let badges = self.createBadges()
        let missions = self.createMissions(badges: badges)
        self.createProgress()
    }

    func createBadges() -> [Badge?] {
        return [
            BadgeManager.shared.create(
                explainText: "Adotar pequenas atitudes na rotina e preparar a casa ou empresa para separar corretamente o lixo é uma das melhores maneiras para ajudar na preservação do meio ambiente. A coleta seletiva evita a disseminação de doenças e contribui para que os resíduos se encaminhem para os seus devidos lugares.",
                imageName: "badge0.jpeg",
                link: "",
                name: "Astro do descarte"
            ),
            BadgeManager.shared.create(
                explainText: "Adotar pequenas atitudes na rotina e preparar a casa ou empresa para separar corretamente o lixo é uma das melhores maneiras para ajudar na preservação do meio ambiente. A coleta seletiva evita a disseminação de doenças e contribui para que os resíduos se encaminhem para os seus devidos lugares.",
                imageName: "badge1.jpeg",
                link: "",
                name: "Patrono do mangue"
            ),
        ]
    }
    
    func createMissions(badges: [Badge?]) -> [Mission?]{
        return [
            MissionManager.shared.create(
                modalText: "A coleta seletiva é uma parte muito importante no descarte correto do nosso lixo! Vamos aprender a colocar cada coisa em seu lugar?",
                modalTitle: "Lixo não é tudo igual!",
                progressEarned: 1,
                badge: badges[0]
            ),
            MissionManager.shared.create(
                modalText: "A vida no mangue está morrendo devido ao lixo. Junte-se ao movimento PE SEM LIXO para limpá-lo.",
                modalTitle: "Mutirão",
                progressEarned: 1,
                badge: badges[1]
            ),
        ]
    }

    func createProgress(){
        
    }
}
