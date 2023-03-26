package br.com.uniamerica.estacionamento.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "veiculo", schema = "public")
public class Veiculo extends AbstractEntity{
    @Id
    @Getter
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id",nullable = false,unique = true)
    private Long id;
    @Getter  @Setter
    @Column(name = "placa",length = 12,nullable = false,unique = true)
    private String placa;
    @Getter  @Setter
    @ManyToOne
    @JoinColumn(name = "modelo",nullable = false)
    private Modelo modelo;

    @Enumerated(EnumType.STRING)
    @Getter @Setter
    @Column(name= "cor",length = 20,nullable = false)
    private Cor cor;
    @Enumerated(EnumType.STRING)
    @Getter @Setter
    @Column(name= "tipo",length = 6,nullable = false)
    private Tipo tipo;
    @Getter  @Setter
    @Column(name = "ano",nullable = false)
    private int ano;


}
