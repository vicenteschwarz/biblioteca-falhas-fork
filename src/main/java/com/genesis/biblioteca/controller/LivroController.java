package com.genesis.biblioteca.controller;

import com.genesis.biblioteca.model.Livro;
import com.genesis.biblioteca.model.LivroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/livros")
public class LivroController {
    @Autowired
    private LivroRepository repo;

    @GetMapping
    public List<Livro> listar() {
        return repo.findAll();
    }

    @PostMapping
    public Livro criar(@RequestBody Livro livro) {
        return repo.save(livro);
    }

    @PutMapping("/{id}")
    public Livro atualizar(@PathVariable Long id, @RequestBody Livro livro) {
        livro.setId(id);
        return repo.save(livro);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        repo.deleteById(id);
    }
}

