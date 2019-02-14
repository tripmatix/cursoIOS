//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by ios8207 on 07/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import Foundation

import UIKit

class GerenciadorDeAcoes: NSObject{
    let contato:Contato
    var controller:UIViewController!
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    func exibirAcoes (em controller:UIViewController) {
        self.controller = controller
        
        let alertView = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default) {action in self.ligar()}
        
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar No Mapa", style: .default) {action in self.abrirMapa()}
        
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar Site", style: .default) {action in self.abrirNavegador()}
        
        let exibirTemperatura = UIAlertAction(title: "Visualizar Clima", style: .default){ action in
            self.exibirTemperatura()
        }
        
        alertView.addAction(cancelar)
        alertView.addAction(ligarParaContato)
        alertView.addAction(exibirContatoNoMapa)
        alertView.addAction(exibirSiteDoContato)
        alertView.addAction(exibirTemperatura)
        
        self.controller.present(alertView, animated: true, completion: nil)
        

    }
    
    func exibirTemperatura(){
        let temperaturaViewController = controller.storyboard?.instantiateViewController(withIdentifier: "temperaturaViewController") as! TemperaturaViewController
        
        temperaturaViewController.contato = self.contato
        
        controller.navigationController?.pushViewController(temperaturaViewController, animated: true)
    }
    
    private func abrirAplicativo(com url:String){
        
        UIApplication
        .shared
            .open(URL(string: url)!, options: [:], completionHandler: nil)
    }
        
    
    private func ligar(){
        let device = UIDevice.current
        
        if device.model == "iPhone"{
            print("UUID \(device.identifierForVendor!)")
            abrirAplicativo(com: "tel:" + self.contato.telefone!)
        }else{
            let alert = UIAlertController(title: "Impossivel fazer ligacoes", message: "Seu dispositivo nao e um iPhone", preferredStyle: .alert)
            
            let acao = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(acao)
            
            self.controller.present(alert, animated: true, completion: nil)
            
        }
    }
    
    private func abrirMapa(){
        print ("abrirMapa")
        
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        abrirAplicativo(com: url)
        
    }
    
    private func abrirNavegador(){
        
        var url = contato.site!
        
        if !url.hasPrefix("http://"){
            url = "http://" + url
        }
        
        abrirAplicativo(com: url)
        
    }
    
    

}
