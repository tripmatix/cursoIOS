//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class ContatoDao: NSObject {
    
    static private var defaultDao: ContatoDao!
    var contatos: Array<Contato>
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
    }
    
    static func sharedInstance() -> ContatoDao{
        if defaultDao == nil {
            
            defaultDao = ContatoDao()
        }
        return defaultDao
    }

//inicializar
    override private init(){
        self.contatos = Array()
        super.init()
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int) -> Contato{
        return contatos[posicao]
    }
    
    func remove(_ posicao:Int){
        contatos.remove(at:posicao)
    }
    
}
