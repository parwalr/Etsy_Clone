package com.rituparwal.ecommerce.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.rituparwal.ecommerce.models.Store;

@Repository
public interface StoreRepo extends CrudRepository<Store, Long> {

}
