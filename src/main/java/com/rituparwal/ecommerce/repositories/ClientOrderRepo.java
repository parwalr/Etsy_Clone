package com.rituparwal.ecommerce.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.rituparwal.ecommerce.models.ClientOrder;

@Repository
public interface ClientOrderRepo extends CrudRepository<ClientOrder, Long> {
	ClientOrder findById(long id);
	List<ClientOrder> findByCheckedOut(boolean checkedOUt);
}
