package com.rituparwal.ecommerce.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name="products")
public class Product {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Name required")
    private String name;
    
    @NotBlank(message = "Category required")
    private String category;
    
    private double price;
    
    @NotBlank(message = "Image required")
    private String image;
    
    @NotBlank(message = "Description required")
    private String description;
    
    @Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="store_id")
    private Store store;
    
    @OneToMany(mappedBy="product", fetch = FetchType.LAZY)
    private List<Rating> ratings;
    
    @OneToMany(mappedBy="product", fetch = FetchType.LAZY)
    private List<OrderProduct> orderProduct;
    

    public Product() {
    	
    }
    
    
    
    
    
    public List<Rating> getRatings() {
		return ratings;
	}





	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}





	public Long getId() {
		return id;
	}



	public String getName() {
		return name;
	}



	public String getCategory() {
		return category;
	}



	public double getPrice() {
		return price;
	}



	public String getImage() {
		return image;
	}



	public String getDescription() {
		return description;
	}



	public Date getCreatedAt() {
		return createdAt;
	}



	public Date getUpdatedAt() {
		return updatedAt;
	}



	public Store getStore() {
		return store;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public void setName(String name) {
		this.name = name;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	public void setPrice(double price) {
		this.price = price;
	}



	public void setImage(String image) {
		this.image = image;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}



	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}



	public void setStore(Store store) {
		this.store = store;
	}
	
	public List<OrderProduct> getOrderProduct() {
		return orderProduct;
	}

	public void setOrderProduct(List<OrderProduct> orderProduct) {
		this.orderProduct = orderProduct;
	}
	
	







	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    
    
    
    
}
