package br.com.uniamerica.estacionamento.controller;

import br.com.uniamerica.estacionamento.entity.Modelo;
import br.com.uniamerica.estacionamento.repository.ModeloRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(value = "/api/modelo")
public class ModeloController {

    @Autowired
    private ModeloRepository modeloRepository;

    @GetMapping("/{id}")
    public ResponseEntity<?>  findByIdPath(@PathVariable("id") final Long id){
        final Modelo modelo = this.modeloRepository.findById(id).orElse(null);
        return modelo == null
                ? ResponseEntity.badRequest().body("Nenhum valor encontrado.")
                : ResponseEntity.ok(modelo);
        //return ResponseEntity.ok(new Modelo());
    }

    @GetMapping("/lista")
    public ResponseEntity<?>  findByIdRequest(@RequestParam("id") final Long id){

        final Modelo modelo = this.modeloRepository.findById(id).orElse(null);
        return modelo == null
                ? ResponseEntity.badRequest().body("Nenhum valor encontrado.")
                : ResponseEntity.ok(modelo);
        //return ResponseEntity.ok(new Modelo());
    }
    @GetMapping
    public ResponseEntity<?>listaCompleta(){
        return ResponseEntity.ok(this.modeloRepository.findAll());
    }

    @PostMapping
    public ResponseEntity<?> cadastrar(@RequestBody final Modelo modelo){
       this.modeloRepository.save(modelo);
        return ResponseEntity.ok ("Registro cadastrado com sucesso");
    }

   @PutMapping
    public ResponseEntity<?> editar(@RequestParam("id") final Long id,
    @RequestBody final Modelo modelo
   ){
        final Modelo modeloBanco = this.modeloRepository.findById(id).orElse(null);

        if (modeloBanco == null){
            throw new RuntimeException("Não foi possivel identificar o registo informado");
        }
        if(modeloBanco.getId()== modelo.getId()){
            throw new RuntimeException("N");
        }

       return null;
   }
}

   // @DeleteMapping

