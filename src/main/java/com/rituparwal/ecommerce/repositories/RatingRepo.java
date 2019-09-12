package com.rituparwal.ecommerce.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.rituparwal.ecommerce.models.Rating;

@Repository
public interface RatingRepo extends CrudRepository<Rating, Long> {

}
