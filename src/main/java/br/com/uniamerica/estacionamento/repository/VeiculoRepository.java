package br.com.uniamerica.estacionamento.repository;

import br.com.uniamerica.estacionamento.entity.Configuracao;
import br.com.uniamerica.estacionamento.entity.Veiculo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface VeiculoRepository extends JpaRepository <Veiculo, Long>{
    @Query(value = "select * from tb_veiculo where saida is null", nativeQuery = true)
    List<Veiculo> findByAtivo();
}
