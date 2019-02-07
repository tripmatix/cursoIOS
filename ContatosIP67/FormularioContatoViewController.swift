//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    @IBOutlet weak var nome:       UITextField!
    @IBOutlet weak var telefone:   UITextField!
    @IBOutlet weak var endereco:   UITextField!
    @IBOutlet weak var site:       UITextField!
    
    var dao:ContatoDao
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        
        super.init(coder: aDecoder)
    }

    var contato: Contato!
    
    @IBAction func criarContato(){
        
        pegaDadosDoFormulario()
        dao.adiciona(contato)
        
/*        for contato in dao.contatos{
            print(dao.contatos)
            print("    ")
        }
 */
        
        _ = self.navigationController?.popViewController(animated: true)
    }   
    
    
    func pegaDadosDoFormulario(){
        
        if contato == nil{
        self.contato = Contato();
//        let contato: Contato = Contato()
        }
        contato.nome     = self.nome.text
        contato.telefone = self.telefone.text
        contato.endereco = self.endereco.text
        contato.site     = self.site.text
    }
 
    func atualizaContato(){
        pegaDadosDoFormulario()
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


