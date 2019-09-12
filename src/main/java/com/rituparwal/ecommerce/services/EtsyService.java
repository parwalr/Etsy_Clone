package com.rituparwal.ecommerce.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.rituparwal.ecommerce.models.ClientOrder;
import com.rituparwal.ecommerce.models.OrderProduct;
import com.rituparwal.ecommerce.models.Product;
import com.rituparwal.ecommerce.models.Rating;
import com.rituparwal.ecommerce.models.Store;
import com.rituparwal.ecommerce.models.User;
import com.rituparwal.ecommerce.repositories.ClientOrderRepo;
import com.rituparwal.ecommerce.repositories.OrderProductRepo;
import com.rituparwal.ecommerce.repositories.ProductRepo;
import com.rituparwal.ecommerce.repositories.RatingRepo;
import com.rituparwal.ecommerce.repositories.StoreRepo;
import com.rituparwal.ecommerce.repositories.UserRepo;


@Service
public class EtsyService {
	private final UserRepo userRepo;
	private final ProductRepo productRepo;
	private final StoreRepo storeRepo;
	private final RatingRepo ratingRepo;
	private final ClientOrderRepo clientOrderRepo;
	private final OrderProductRepo orderProductRepo;
	
    public EtsyService(UserRepo userRepo,ProductRepo productRepo, StoreRepo storeRepo, RatingRepo ratingRepo, ClientOrderRepo clientOrderRepo, OrderProductRepo orderProductRepo) {
        this.userRepo = userRepo;
        this.storeRepo = storeRepo;
        this.productRepo = productRepo;
        this.ratingRepo = ratingRepo;
        this.clientOrderRepo = clientOrderRepo;
        this.orderProductRepo = orderProductRepo;
    }
    
    
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
    
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
    
    public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepo.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    public void deleteProduct(Long id) {
    	productRepo.deleteById(id);
    }
    
    public List<Product> allProducts() {
    	return (List<Product>) productRepo.findAll();
    }
    
	public Product addProduct(Product product) {
		return productRepo.save(product);
	}
	
    public Product findProductById(Long id) {
    	Optional<Product> p = productRepo.findById(id);
    	if(p.isPresent()) {
            return p.get();
    	}
    	else {
    	    return null;
    	}
    }
    
    public void updateProduct(Product product) {
    	productRepo.save(product);
    }
    
    public void updateUser(User user) {
        userRepo.save(user);
    }
    
	public Rating addRating(Rating rating) {
		return ratingRepo.save(rating);
	}
	
    public void newRating(Rating rating) {
        ratingRepo.save(rating);
    }
    
    public void deleteStore(Long id) {
    	storeRepo.deleteById(id);
    }
    
    public List<Store> allStores() {
    	return (List<Store>) storeRepo.findAll();
    }
    
	public Store addStore(Store store) {
		return storeRepo.save(store);
	}
	
    public Store findStoreById(Long id) {
    	Optional<Store> s = storeRepo.findById(id);
    	if(s.isPresent()) {
            return s.get();
    	}
    	else {
    	    return null;
    	}
    }
    
    public void updateStore(Store store) {
    	storeRepo.save(store);
    }
    
	public List<Product> getSearchProducts(String product){
		return productRepo.findByNameStartingWith(product);
	}
	
	public List<Product> getCategoryProducts(String category){
		return productRepo.findByCategory(category);
	}
	
    public ClientOrder save(ClientOrder clientOrder) {
        return clientOrderRepo.save(clientOrder);
    }
    public ClientOrder findClientOrderById(long id) {
    	return clientOrderRepo.findById(id);
    }
    public void deleteClientOrder(long id) {
    	clientOrderRepo.deleteById(id);
    }
    public List<ClientOrder> findActive(){
    	return clientOrderRepo.findByCheckedOut(false);
    }
    
    public OrderProduct save(OrderProduct orderProduct) {
        return orderProductRepo.save(orderProduct);
    }
    public OrderProduct findOrderProductById(long id){
        return orderProductRepo.findById(id);
    }
    
    
    public void deleteOrderProduct(long id) {
    	orderProductRepo.deleteById(id);
    }
	
    
}
