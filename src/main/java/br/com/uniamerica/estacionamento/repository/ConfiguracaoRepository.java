package br.com.uniamerica.estacionamento.repository;

import br.com.uniamerica.estacionamento.entity.Configuracao;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ConfiguracaoRepository extends JpaRepository<Configuracao, Long> {
    public List<Configuracao> findByNome(final String nome);
}
