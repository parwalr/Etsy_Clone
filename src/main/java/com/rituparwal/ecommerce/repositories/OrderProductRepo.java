package com.rituparwal.ecommerce.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.rituparwal.ecommerce.models.OrderProduct;

@Repository
public interface OrderProductRepo extends CrudRepository<OrderProduct, Long> {
	OrderProduct findById(long id);
}
