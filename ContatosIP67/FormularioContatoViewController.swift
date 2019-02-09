//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nome:       UITextField!
    @IBOutlet weak var telefone:   UITextField!
    @IBOutlet weak var endereco:   UITextField!
    @IBOutlet weak var site:       UITextField!
    @IBOutlet weak var imageView:  UIImageView!
    
    var dao:ContatoDao
    
    var delegate: FormularioContatoViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        
        super.init(coder: aDecoder)
    }
    
    var contato: Contato!
    
    @IBAction func criarContato(){
        
        //       pegaDadosDoFormulario()
        self.pegaDadosDoFormulario()
        dao.adiciona(contato)
        
        self.delegate?.contatoAdicionado(contato)
        
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
        contato.foto     = self.imageView.image
    }
    
    func atualizaContato(){
        pegaDadosDoFormulario()
        
        self.delegate?.contatoAtualizado(contato)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func selecionaFoto(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let alert = UIAlertController(title: "Escolha foto do contato", message: self.contato
                .nome, preferredStyle: .actionSheet)
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            let tirarFoto = UIAlertAction(title: "Tirar Foto", style: .default){ (action) in
            self.pegarImagem(da: .camera)
            }
            
            let escolherFoto = UIAlertAction(title: "Escolher da biblioteca", style: .default){ (action) in self.pegarImagem(da: .photoLibrary)
            }
            
            alert.addAction(cancelar)
            alert.addAction(tirarFoto)
            alert.addAction(escolherFoto)
            
            self.present(alert, animated: true, completion: nil)
            
        }else {
            pegarImagem(da: .photoLibrary)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageView.image = imagemSelecionada

        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func pegarImagem(da sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            if let foto = contato.foto{
                self.imageView.image = self.contato.foto
            }
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        //            imageView.layer.borderColor = UIColor.blackColor().CGColor
        //            imageView.layer.cornerRadius = borderColor = profilepic.frame.height/2
        imageView.clipsToBounds = true
        //            slider.addSubview(profilepic)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender:)))
        
        self.imageView.addGestureRecognizer(tap)
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


