//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class ContatoDao: CoreDataUtil {
    
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
        self.inserirDadosIniciais()
        print ("Caminho do BD: \(NSHomeDirectory())")
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
    
    func buscaPosicaoContato (_ contato:Contato) -> Int {
        return contatos.index(of: contato)!
    }
    
    func inserirDadosIniciais(){
        let configuracoes = UserDefaults.standard
        
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos{
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "São Paulo, SP, Rua Vergueiro, 3185";
            caelumSP.telefone = "01155712751";
            caelumSP.site = "http://www.caelum.com.br";
            caelumSP.latitude = -23.5883034
            caelumSP.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            
            configuracoes.synchronize()
            
        }
    }
    
}
