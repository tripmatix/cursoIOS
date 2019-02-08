//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class ListaContatosViewController: UITableViewController, FormularioContatoViewControllerDelegate {
    
    var dao:ContatoDao
    
    var linhaDestaque: IndexPath?
    
    static let cellIdentifier = "Cell"
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(exibirMaisAcoes(gesture:)))
        
        self.tableView.addGestureRecognizer(longPress)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dao.listaTodos().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let contato:Contato = self.dao.buscaContatoNaPosicao(indexPath.row)
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ListaContatosViewController.cellIdentifier)
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: ListaContatosViewController.cellIdentifier)
        }
        
        cell!.textLabel?.text = contato.nome
        cell!.detailTextLabel?.text = contato.endereco
        
        return cell!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        if let linha = self.linhaDestaque{
            
            self.tableView.selectRow(at: self.linhaDestaque!, animated: true, scrollPosition: .middle)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                self.tableView.deselectRow(at: linha, animated: true)
                self.linhaDestaque = Optional.none
            }
            
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            self.dao.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let contatoSelecionado = dao.buscaContatoNaPosicao(indexPath.row)
        self.exibeFormulario(contatoSelecionado)
        
        print("Nome: \(contatoSelecionado.nome)")
    }
    
    func exibeFormulario(_ contato:Contato){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let formulario = storyboard.instantiateViewController(withIdentifier: "Form-Contato") as!FormularioContatoViewController
        
        formulario.delegate = self
        formulario.contato = contato
        
        self.navigationController?.pushViewController(formulario, animated: true)
    }
    
    func contatoAtualizado(_ contato:Contato){
        self.linhaDestaque = IndexPath(row: dao.buscaPosicaoContato(contato), section: 0)
    }
    
    func contatoAdicionado(_ contato:Contato){
        self.linhaDestaque = IndexPath(row: dao.buscaPosicaoContato(contato), section: 0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "FormSegue"{
            if let formulario = segue.destination as? FormularioContatoViewController{
                formulario.delegate = self
            }
        }
    }
    
    
    func exibirMaisAcoes(gesture: UIGestureRecognizer){
        if gesture.state == .began{
            
            let ponto = gesture.location(in: self.tableView)
            
            if let indexPath = self.tableView.indexPathForRow(at:ponto){
                let contato = self.dao.buscaContatoNaPosicao(indexPath.row)
                
                let acoes = GerenciadorDeAcoes(do: contato)
                
                acoes.exibirAcoes(em: self)
            }
        }
        
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

