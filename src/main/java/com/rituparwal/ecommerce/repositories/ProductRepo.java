package com.rituparwal.ecommerce.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.rituparwal.ecommerce.models.Product;

@Repository
public interface ProductRepo extends CrudRepository <Product, Long> {
	List<Product> findByNameStartingWith(String search);
	List<Product> findByCategory(String category);
}
